"""
Netlify deployment wrapper for Rocky Flask app
This file ensures Flask app runs on Netlify's serverless platform
"""
import os
import sys
from werkzeug.serving import WSGIRequestHandler
from web_app import app

# Disable Flask reloader on Netlify
app.config['ENV'] = 'production'

# Handle Netlify environment
if os.environ.get('NETLIFY'):
    # Running on Netlify
    app.config['DEBUG'] = False
else:
    # Local development
    app.config['DEBUG'] = True

# Export app for Netlify Functions
handler = app

if __name__ == "__main__":
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port, debug=False)
