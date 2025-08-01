import json
import boto3
import os

dynamodb = boto3.resource('dynamodb')
table_name = os.environ.get('TABLE_NAME', 'dynamic-string-table')
table = dynamodb.Table(table_name)

def lambda_handler(event, context):
    try:
        # Get item from DynamoDB
        response = table.get_item(Key={'id': 'welcome-text'})
        message = response.get('Item', {}).get('message', 'No message found.')

        return {
            "statusCode": 200,
            "headers": {
                "Content-Type": "application/json",
                "Access-Control-Allow-Origin": "*"
            },
            "body": json.dumps({"message": message})
        }

    except Exception as e:
        return {
            "statusCode": 500,
            "headers": {
                "Content-Type": "application/json",
                "Access-Control-Allow-Origin": "*"
            },
            "body": json.dumps({"error": str(e)})
        }




