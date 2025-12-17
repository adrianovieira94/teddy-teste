import os
import boto3
from datetime import datetime, timezone

dynamodb = boto3.resource("dynamodb")
table_name = os.environ.get("TABLE_NAME", "teddy-teste")
table = dynamodb.Table(table_name)

def lambda_handler(event, context):
    timestamp = datetime.now(timezone.utc).isoformat()

    item = {
        "id": context.aws_request_id,
        "executed_at": timestamp
    }

    table.put_item(Item=item)

    print(f"[SUCESSO] Registro inserido na tabela {table_name}: {item}")

    return {
        "statusCode": 200,
        "body": f"Registro inserido às {timestamp}"
    }