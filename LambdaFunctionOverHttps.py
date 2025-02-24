import json
import boto3

# Define the DynamoDB table
table_name = "lambda-apigateway"
dynamo = boto3.resource('dynamodb').Table(table_name)

# Define operations
def create(payload):
    return dynamo.put_item(Item=payload['Item'])

def read(payload):
    return dynamo.get_item(Key=payload['Key'])

def update(payload):
    return dynamo.update_item(**{k: payload[k] for k in ['Key', 'UpdateExpression', 
    'ExpressionAttributeNames', 'ExpressionAttributeValues'] if k in payload})

def delete(payload):
    return dynamo.delete_item(Key=payload['Key'])

operations = {
    'create': create,
    'read': read,
    'update': update,
    'delete': delete,
}

def lambda_handler(event, context):
    try:
        # Parse the event body if it's from API Gateway
        if "body" in event:
            event = json.loads(event["body"])  # Convert string to dictionary

        operation = event.get("operation")  
        if not operation:
            return {"statusCode": 400, "body": json.dumps({"error": "Missing 'operation' key"})}

        if operation not in operations:
            return {"statusCode": 400, "body": json.dumps({"error": "Invalid operation"})}

        payload = event.get("payload", {})
        if not payload:
            return {"statusCode": 400, "body": json.dumps({"error": "Missing payload"})}

        # Execute the operation
        result = operations[operation](payload)

        return {"statusCode": 200, "body": json.dumps({"message": "Success", "data": result})}

    except Exception as e:
        return {"statusCode": 500, "body": json.dumps({"error": str(e)})}


# import boto3

# # Define the DynamoDB table that Lambda will connect to
# table_name = "lambda-apigateway"

# # Create the DynamoDB resource
# dynamo = boto3.resource('dynamodb').Table(table_name)

# # Define some functions to perform the CRUD operations
# def create(payload):
#     return dynamo.put_item(Item=payload['Item'])

# def read(payload):
#     return dynamo.get_item(Key=payload['Key'])

# def update(payload):
#     return dynamo.update_item(**{k: payload[k] for k in ['Key', 'UpdateExpression', 
#     'ExpressionAttributeNames', 'ExpressionAttributeValues'] if k in payload})

# def delete(payload):
#     return dynamo.delete_item(Key=payload['Key'])

# def echo(payload):
#     return payload

# operations = {
#     'create': create,
#     'read': read,
#     'update': update,
#     'delete': delete,
#     'echo': echo,
# }




# def lambda_handler(event, context):
#     try:
#         operation = event.get("operation")  # Use .get() to avoid KeyError
#         if not operation:
#             return {"statusCode": 400, "body": "Missing 'operation' key"}
        
#         # Handle operations like 'create', 'update', etc.
#         if operation == "create":
#             item = event.get("payload", {}).get("Item")
#             if not item:
#                 return {"statusCode": 400, "body": "Missing 'Item' in payload"}

#             # Process the create operation here...

#         return {"statusCode": 200, "body": "Success"}
    
#     except Exception as e:
#         return {"statusCode": 500, "body": str(e)}




# def lambda_handler(event, context):
#     '''Provide an event that contains the following keys:
#       - operation: one of the operations in the operations dict below
#       - payload: a JSON object containing parameters to pass to the 
#         operation being performed
#     '''
    
#     operation = event['operation']
#     payload = event['payload']
    
#     if operation in operations:
#         return operations[operation](payload)
        
#     else:
#         raise ValueError(f'Unrecognized operation "{operation}"')