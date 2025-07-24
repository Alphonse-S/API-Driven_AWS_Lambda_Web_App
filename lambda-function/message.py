# This Lambda function retrieves a dynamic message from a DynamoDB table
import json
import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('dynamic-string-table')

def lambda_handler(event, context):
    response = table.get_item(Key={'id': 'welcome-text'})
    message = response.get('Item', {}).get('message', 'No message found')
    return {
        'statusCode': 200,
        'headers': {'Content-Type': 'application/json'},
        'body': json.dumps({'message': message})
    }

