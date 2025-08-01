# Project Overview
This project provisions a fully serverless solution on AWS, using Terraform to manage infrastructure as code. It serves a static HTML page that fetches and displays a dynamically stored string, which can be updated without re-deploying the site.

Any user accessing the public URL will see the same dynamic value, and it can be changed at runtime via an admin API or CLI call — no redeploy needed.


## Features
Static Hosting	S3	Hosts the HTML file that fetches the dynamic string
Backend API	API Gateway (HTTP API)	Exposes a public HTTP endpoint
Compute	AWS Lambda	Serves GET/POST requests with business logic
Data Store	DynamoDB	Stores the current string value
Provisioning	Terraform	Declares and deploys all cloud resources

## Flow
User visits a public S3 site URL (index.html)

JavaScript fetch() calls API Gateway

API Gateway triggers a Lambda function

Lambda reads from DynamoDB and returns the current string

Response is shown on the HTML page


## Prerequisites

- Install terraform .
- AWS account with appropriate permissions.
- AWS CLI configured with credentials.

## Usage

1. Clone the repository:
    ```bash
    git clone https://github.com/Alphonse-S/API-Driven_AWS_Lambda_Web_App.git
    ```

2. Initialize Terraform:
    ```bash
    terraform init
    ```

3. Review and customize `variables.tf` as needed.

4. Apply the configuration:
    ```bash
    terraform apply
    ```

5. Confirm the deployment and note the output for accessing the service.

## Project Structure
├── terraform/
│   ├── main.tf                # Core infra: S3, Lambda, API Gateway, DynamoDB
│   ├── variables.tf
│   ├── outputs.tf
├── html/
│   ├── index.template.html    # HTML file with placeholder for API URL
├── scripts/
│   ├── deploy.sh              # Upload HTML to S3 with URL replacement
├── lambda/
│   ├── handler.py             # Python Lambda to GET/POST string to DynamoDB
├── README.md
└── solution.pdf 


## Cleanup

To destroy the infrastructure:
```bash
terraform destroy
```

## Contributing

Contributions are welcome! Please open an issue or submit a pull request.

## Contact

For questions or support, contact [alphonsesagoe234@gmail.com].
