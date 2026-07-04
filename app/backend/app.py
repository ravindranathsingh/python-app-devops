import os
import time
from flask import Flask, jsonify, request
from flask_cors import CORS
import psycopg2

app = Flask(__name__)
CORS(app, resources={r"/api/*": {"origins": "*"}})

# Read infrastructure configuration directly from environment variables (DevOps Best Practice)
DB_HOST = os.getenv("DB_HOST", "localhost")
DB_NAME = os.getenv("DB_NAME", "devops_db")
DB_USER = os.getenv("DB_USER", "postgres")
DB_PASS = os.getenv("DB_PASS", "securepassword")

def get_db_connection():
    return psycopg2.connect(host=DB_HOST, database=DB_NAME, user=DB_USER, password=DB_PASS)

# Initialize schema settings upon service launch
def init_db():
    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute("""
            CREATE TABLE IF NOT EXISTS deployments (
                id SERIAL PRIMARY KEY,
                service VARCHAR(100) NOT NULL,
                environment VARCHAR(50) NOT NULL,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            );
        """)
        conn.commit()
        cur.close()
        conn.close()
    except Exception as e:
        print(f"Database initialization deferred (Waiting on availability)... Error: {e}")

@app.route('/api/health', methods=['GET'])
def health_check():
    try:
        conn = get_db_connection()
        conn.close()
        return jsonify({"status": "healthy", "database": "connected"}), 200
    except Exception as e:
        return jsonify({"status": "unhealthy", "error": str(e)}), 500

@app.route('/api/deployments', methods=['GET'])
def get_deployments():
    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute("SELECT service, environment, created_at FROM deployments ORDER BY id DESC;")
        rows = cur.fetchall()
        cur.close()
        conn.close()
        
        logs = [{"service": r[0], "environment": r[1], "timestamp": r[2].strftime('%Y-%m-%d %H:%M:%S')} for r in rows]
        return jsonify(logs), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/deployments', methods=['POST'])
def add_deployment():
    data = request.json
    service = data.get('service')
    environment = data.get('environment')
    
    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute("INSERT INTO deployments (service, environment) VALUES (%s, %s);", (service, environment))
        conn.commit()
        cur.close()
        conn.close()
        return jsonify({"message": "Log stored successfully!"}), 201
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    init_db() 
    app.run(host='0.0.0.0', port=5000, debug=True)