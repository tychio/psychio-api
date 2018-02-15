#!/usr/bin/python
import sys
import json

from qcloud_cos import CosConfig
from qcloud_cos import CosS3Client
from qcloud_cos import CosServiceError
from qcloud_cos import CosClientError

secret_id = sys.argv[1]
secret_key = sys.argv[2]
region = 'ap-chengdu'
token = ''
config = CosConfig(Region=region, Secret_id=secret_id, Secret_key=secret_key, Token=token)
client = CosS3Client(config)

response = client.list_objects(
    Bucket='results-1255403486',
    Marker='picture-naming/records',
    Prefix='picture-naming',
    Delimiter='-'
)

contents = response['Contents']
keys = []

for content in contents:
    keys.append(content['Key'])

def get_object(key):
    stream = client.get_object(
        Bucket='results-1255403486',
        Key=key
    )
    return stream['Body'].get_raw_stream().read()

files = map(get_object, keys)

print json.dumps(files)
