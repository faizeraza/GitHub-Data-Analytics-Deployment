# GitHub Data Analytics Project Deployment Guide

This repository provides step-by-step instructions for deploying the GitHub Data Analytics (GDA) project on AWS. The GDA project focuses on extracting valuable insights from GitHub repositories.

## Table of Contents
1. [Set-up Database](#set-up-database)
    1. [Create an AWS RDS PostgreSQL Instance](#create-an-aws-rds-postgresql-instance)
    2. [Connect to RDS using pgAdmin](#connect-to-rds-using-pgadmin)
    3. [Backup the Database](#backup-the-database)
2. [Deploy ETL Code](#deploy-etl-code)
    1. [Build and Test Docker Image](#build-and-test-docker-image)
    2. [Deploy the Docker Image on AWS Lambda](#deploy-the-docker-image-on-aws-lambda)
3. [Set Trigger using CloudWatch](#set-trigger-using-cloudwatch)
4. [Connect Dashboard](#connect-dashboard)

## Set-up Database

### Create an AWS RDS PostgreSQL Instance
Follow the official AWS documentation to create an RDS PostgreSQL instance:
- [Create an Amazon RDS DB Instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_GettingStarted.CreatingConnecting.PostgreSQL.html#CHAP_GettingStarted.Creating.PostgreSQL)

### Connect to RDS using pgAdmin
Use pgAdmin to connect to your RDS PostgreSQL instance:
- [Connect to a PostgreSQL DB Instance using pgAdmin](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_ConnectToPostgreSQLInstance.html#USER_ConnectToPostgreSQLInstance.pgAdmin)

### Backup the Database
Learn how to back up your PostgreSQL database using pgAdmin:
- [How to Backup PostgreSQL Database using pgAdmin](https://hevodata.com/learn/pgadmin-backup-database/#5)

## Deploy ETL Code

### Build and Test Docker Image
Watch this video for a step-by-step guide on building and testing a Docker image:
- [YouTube: Building and Testing Lambda Function Docker Images](https://www.youtube.com/watch?v=wbsbXfkv47A)

1. Open a command prompt in the image directory.
2. Build the Docker image:
   ```shell
   docker build --platform linux/amd64 -t docker-image:test .
3. Run the test locally using the following command:
   '''shell
   docker run -p 9000:8080 docker-image:test
4. From a new terminal window, post an event to the Lambda function's endpoint using a curl command. Replace "daily" with "monthly" or "weekly" as needed.
   '''shell
   curl "http://localhost:9000/2015-03-31/functions/function/invocations" -d "{\"schedule\":\"daily\"}"
5. Complete the Deployment Process
For the rest of the deployment process, refer to the blogs and resources mentioned in the video.
## Set Trigger Using CloudWatch
Configure triggers for your Lambda function using AWS CloudWatch.

-[AWS CloudWatch EventBridge Rules](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-rules.html)
Create three different rules with custom JSON inputs for "daily," "weekly," and "monthly," respectively.
## Connect Dashboard
1. -[Download Power BI Dashboard](https://github.com/faizeraza/dataengineering-github-data-pipelineline/blob/main/GDAv2.1_Dashboard.pbix)
2. Configure Power BI
3. Open the Power BI Dashboard and click on "Get Data Source."
4. Fill in the details, including the host name (endpoint) of your AWS RDS instance, the database name, and the password.
### Summary:
This README file provides a detailed guide for deploying your GitHub Data Analytics project on AWS, including creating the database, deploying the ETL code, setting up triggers, and connecting the Power BI dashboard.





