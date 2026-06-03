import os
import sys
import aws_lambda_wsgi

# Add project root to sys.path so we can import modules from the root
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))

from main import app

def handler(event, context):
    return aws_lambda_wsgi.response(app, event, context)
