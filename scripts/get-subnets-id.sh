aws ec2 describe-subnets --query 'Subnets[*].{ID:SubnetId,Name:Tags[0].Value}' --output json > subnets-id.json
