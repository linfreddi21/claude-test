from flask import Flask, jsonify, request

app = Flask(__name__)

@app.route('/')
def home():
    return jsonify({'message': 'Welcome to the simple webapp!'})

@app.route('/api/users', methods=['GET'])
def get_users():
    users = [
        {'id': 1, 'name': 'Alice', 'email': 'alice@example.com'},
        {'id': 2, 'name': 'Bob', 'email': 'bob@example.com'}
    ]
    return jsonify({'users': users})

@app.route('/api/users', methods=['POST'])
def create_user():
    data = request.get_json()
    if not data or 'name' not in data or 'email' not in data:
        return jsonify({'error': 'Name and email are required'}), 400
    
    user = {
        'id': 3,
        'name': data['name'],
        'email': data['email']
    }
    return jsonify({'user': user}), 201

@app.route('/api/health', methods=['GET'])
def health_check():
    return jsonify({'status': 'healthy', 'timestamp': '2024-01-01T00:00:00Z'})

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)