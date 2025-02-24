<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Terraform AWS Lambda REST API with DynamoDB</title>
    <style>
        body { font-family: Arial, sans-serif; line-height: 1.6; margin: 40px; }
        h1, h2, h3 { color: #333; }
        code { background: #f4f4f4; padding: 3px 6px; border-radius: 5px; }
        pre { background: #eee; padding: 10px; border-radius: 5px; overflow-x: auto; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background: #f4f4f4; }
    </style>
</head>
<body>
    <h1>🚀 Terraform AWS Lambda REST API with DynamoDB</h1>
    <p>This Terraform script provisions a <strong>REST API</strong> on AWS using <strong>API Gateway</strong>, <strong>Lambda</strong>, and <strong>DynamoDB</strong> to perform <strong>CRUD operations</strong>.</p>

    <h2>📝 Features</h2>
    <ul>
        <li>✅ <strong>Serverless Architecture</strong>: Uses AWS Lambda for handling API requests.</li>
        <li>✅ <strong>REST API with API Gateway</strong>: Exposes Lambda via HTTP endpoints.</li>
        <li>✅ <strong>DynamoDB Integration</strong>: Performs <strong>Create, Read, Update, Delete (CRUD)</strong> operations.</li>
        <li>✅ <strong>Terraform Infrastructure as Code (IaC)</strong>: Fully automated deployment.</li>
        <li>✅ <strong>Minimal Configuration Required</strong>: Easily deployable with environment variables.</li>
    </ul>


    <h2>⚡ Quick Start</h2>
    <h3>1️⃣ Prerequisites</h3>
    <p>Ensure you have the following installed:</p>
    <ul>
        <li><a href="https://developer.hashicorp.com/terraform/downloads">Terraform</a> (v1.x+)</li>
        <li><a href="https://aws.amazon.com/cli/">AWS CLI</a></li>
        <li>An <strong>AWS account</strong> with necessary permissions.</li>
    </ul>
    
    <h3>2️⃣ Clone the Repository</h3>
    <pre><code>git clone https://github.com/&lt;your-github-username&gt;/terraform-aws-lambda-restapi.git
cd terraform-aws-lambda-restapi</code></pre>
    
    <h3>3️⃣ Configure AWS Credentials</h3>
    <pre><code>aws configure</code></pre>
    
    <h3>4️⃣ Initialize Terraform</h3>
    <pre><code>terraform init</code></pre>
    
    <h3>5️⃣ Deploy the Infrastructure</h3>
    <pre><code>terraform apply -auto-approve</code></pre>
    <p>After deployment, Terraform will output the <strong>API Gateway URL</strong>.</p>
    
    <h3>6️⃣ Test the API</h3>
    <pre><code>curl -X POST https://&lt;api-gateway-url&gt;/create -d '{"id": "1", "name": "Item1"}' -H "Content-Type: application/json"</code></pre>

    <h2>🌍 API Endpoints</h2>
    <table>
        <tr>
            <th>Method</th>
            <th>Endpoint</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>POST</td>
            <td>/create</td>
            <td>Create a new item</td>
        </tr>
        <tr>
            <td>GET</td>
            <td>/read/{id}</td>
            <td>Retrieve an item</td>
        </tr>
        <tr>
            <td>PUT</td>
            <td>/update/{id}</td>
            <td>Update an item</td>
        </tr>
        <tr>
            <td>DELETE</td>
            <td>/delete/{id}</td>
            <td>Delete an item</td>
        </tr>
    </table>

    <h2>🛑 Destroying the Infrastructure</h2>
    <pre><code>terraform destroy -auto-approve</code></pre>
    
    <h2>📌 Best Practices Followed</h2>
    <ul>
        <li><strong>State Management</strong>: Uses Terraform backend for state persistence.</li>
        <li><strong>Modular Design</strong>: API Gateway, Lambda, and DynamoDB are modularized.</li>
        <li><strong>Security</strong>: Environment variables are used to manage sensitive data.</li>
        <li><strong>Scalability</strong>: Serverless architecture ensures cost-efficient scaling.</li>
    </ul>
    
    <h2>🛠️ Troubleshooting</h2>
    <ul>
        <li><strong>Terraform Errors?</strong> Run <code>terraform fmt</code> and <code>terraform validate</code> to check syntax.</li>
        <li><strong>Lambda Deployment Issues?</strong> Verify IAM roles and permissions in AWS.</li>
        <li><strong>API Gateway Not Responding?</strong> Check deployed API Gateway logs in AWS CloudWatch.</li>
    </ul>

   
</body>
</html>
