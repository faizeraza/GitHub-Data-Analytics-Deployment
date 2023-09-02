# GitHub Data Analytics Project Deployment Guide

## Overview

This repository contains instructions and resources for deploying the GitHub Data Analytics (GDA) project infrastructure on Amazon Web Services (AWS). The GDA project focuses on collecting, analyzing, and visualizing data from GitHub repositories.

## Deployment Workflow

The project's deployment workflow involves the following components:

1. **AWS CloudWatch Triggers**: AWS CloudWatch is used to schedule events that trigger the Lambda function at regular intervals (daily, weekly, and monthly).

2. **AWS Lambda Function**: The Lambda function contains the core logic for data extraction, transformation, and loading (ETL). It is deployed using a Docker image stored in Amazon Elastic Container Registry (ECR).

3. **ECR Docker Image**: The ECR image is created from a Docker image built locally. This image includes all the necessary dependencies for the ETL process.

4. **GitHub API Communication**: The ETL code communicates with the GitHub V3 REST API to fetch data from GitHub repositories.

5. **AWS RDS Database**: An Amazon RDS instance hosts the PostgreSQL database where the transformed data is stored.

6. **Power BI Integration**: The PostgreSQL database is connected to a Power BI dashboard for data visualization.

## Challenges Faced

During the deployment of the project, several challenges were encountered and overcome:

1. **PyGitHub Package Compatibility**: The PyGitHub package, required for interacting with the GitHub API, is not available in the AWS Lambda environment and is not compatible with Python 3.11. To solve this, a Docker container image was built locally and deployed to ECR, which is used by Lambda.

## Tools and Technologies Used

Throughout the deployment process, several AWS services and tools were employed:

- AWS CloudWatch: For scheduling Lambda function triggers.
- AWS Lambda: For executing the ETL process.
- AWS CLI: For creating and managing AWS resources via the command line.
- Amazon Elastic Container Registry (ECR): For storing and deploying Docker container images.
- Amazon RDS: For hosting the PostgreSQL database.
- AWS Rules and Policies: For defining permissions and access control.

## Getting Started

To deploy the GitHub Data Analytics project on your AWS account, follow the step-by-step instructions in the [Deployment Guide](./deployment-guide.md).

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.

## Acknowledgments

Special thanks to [Name of the YouTuber or Mentor] for providing guidance and knowledge-sharing throughout this project.
