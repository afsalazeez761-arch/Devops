#!/bin/bash

# Define variables
USER_NAME="developer-user"
POLICY_ARN="arn:aws:iam::aws:policy/ReadOnlyAccess"

# Securely prompt for the initial password
read -sp "Enter the initial password for the new user: " PASSWORD
echo ""

echo "Creating IAM user: $USER_NAME..."
# 1. Create the base IAM user account
aws iam create-user --user-name "$USER_NAME"

echo "Setting up console login profile..."
# 2. Enable Management Console access by assigning the password
aws iam create-login-profile \
    --user-name "$USER_NAME" \
    --password "$PASSWORD" \
    --password-reset-required

echo "Attaching policy..."
# 3. Attach standard permissions directly to the user
aws iam attach-user-policy \
    --user-name "$USER_NAME" \
    --policy-arn "$POLICY_ARN"

echo "IAM user registration complete."
