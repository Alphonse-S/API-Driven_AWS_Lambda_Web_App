import json
import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('dynamic-string-table')

def lambda_handler(event, context):
    response = table.get_item(Key={'id': 'welcome-text'})
    message = response.get('Item', {}).get('message', 'Hello from Terraform! 🚀')
    
    return {
        'statusCode': 200,
        'headers': {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*',  
            'Access-Control-Allow-Methods': 'GET',  
        },
        'body': json.dumps({'message': message})
    }


