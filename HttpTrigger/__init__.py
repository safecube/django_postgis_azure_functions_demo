import os
import sys

import azure.functions as func

sys.path.append(os.getcwd())

from django_postgis_azure_functions_demo.wsgi import application
from wsgi_adapter import AzureWSGIHandler


azure_app = AzureWSGIHandler(application)

def main(req: func.HttpRequest) -> func.HttpResponse:
    return azure_app(req)
