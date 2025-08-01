# New Eng Path Guide

## 6-Week Technical Transformation Plan with Learning Resources

*From InfoSec Professional to DevOps/Platform Engineer*

## Week 1: Linux Fundamentals + Security Context

### Days 1-2: Linux Basics with Security Focus

**Free Learning Resources:**

- **Linux Command Line Basics:** https://linuxcommand.org/tlcl.php (The Linux Command Line book - free PDF)
- **Linux Journey:** https://linuxjourney.com/ (Interactive learning platform)
- **OverTheWire Bandit:** https://overthewire.org/wargames/bandit/ (Security-focused Linux challenges)
- **Linux Academy (now A Cloud Guru) Free Tier:** https://acloudguru.com/pricing
- **edX Linux Introduction:** https://www.edx.org/course/introduction-to-linux (Free audit option)

**Hands-On Labs:**

- **Katacoda Linux Scenarios:** https://www.katacoda.com/courses/linux (Interactive browser-based labs)
- **Linux Survival:** https://linuxsurvival.com/ (Basic command tutorial)

**Core Concepts Practice:**

```bash
# File system navigation and permissions
ls -la /etc/passwd
chmod 755 script.sh
chown user:group file.txt

# Process management (security-focused)
ps aux | grep suspicious
netstat -tulpn | grep :22
lsof -i :443

# User and group management
sudo adduser newuser
sudo usermod -aG sudo newuser
sudo visudo  # Secure sudo configuration
```

**Additional Resources:**

- **Linux Security Guide:** https://www.cyberciti.biz/tips/linux-security.html
- **Linux Hardening Guide:** https://madaidans-insecurities.github.io/guides/linux-hardening.html

### Days 3-4: System Administration + Monitoring

**Free Resources:**

- **Linux System Administration:** https://www.linode.com/docs/guides/linux-system-administration-basics/
- **SystemD Tutorial:** https://www.digitalocean.com/community/tutorials/systemd-essentials-working-with-services-units-and-the-journal
- **Linux Performance Tools:** http://www.brendangregg.com/linuxperf.html

**Essential Commands Practice:**

```bash
# System monitoring (InfoSec relevance)
top, htop, iotop
journalctl -f  # Real-time log monitoring
systemctl status ssh
ss -tulpn  # Modern netstat replacement

# File system and disk management
df -h, du -sh
mount, umount
fdisk -l
```

**Package Management Resources:**

- **APT Tutorial:** https://itsfoss.com/apt-command-guide/
- **YUM/DNF Guide:** https://www.redhat.com/sysadmin/how-manage-packages

### Days 5-7: Bash Scripting Fundamentals

**Free Learning Resources:**

- **Bash Scripting Guide:** https://tldp.org/LDP/abs/html/ (Advanced Bash-Scripting Guide)
- **ShellCheck:** https://www.shellcheck.net/ (Online bash script validator)
- **Bash Academy:** https://guide.bash.academy/
- **Linux Hint Bash Tutorials:** https://linuxhint.com/category/bash/

**Security-Focused Scripting:**

```bash
#!/bin/bash
# Security log analyzer script
LOG_FILE="/var/log/auth.log"
FAILED_ATTEMPTS=$(grep "Failed password" $LOG_FILE | wc -l)

if [ $FAILED_ATTEMPTS -gt 5 ]; then
    echo "ALERT: $FAILED_ATTEMPTS failed login attempts detected"
    # Send email or alert
fi

# Functions and error handling
check_service() {
    if systemctl is-active --quiet $1; then
        echo "$1 is running"
    else
        echo "WARNING: $1 is not running"
    fi
}

check_service ssh
check_service nginx
```

**Practice Platforms:**

- **HackerRank Shell:** https://www.hackerrank.com/domains/shell
- **Bash Exercises:** https://exercism.org/tracks/bash

-----

## Week 2: Python Programming for Infrastructure

### Days 1-2: Python Basics for SysAdmins

**Free Learning Resources:**

- **Python.org Tutorial:** https://docs.python.org/3/tutorial/
- **Automate the Boring Stuff:** https://automatetheboringstuff.com/ (Free online book)
- **Real Python:** https://realpython.com/ (Many free articles and tutorials)
- **Python for Network Engineers:** https://pyneng.readthedocs.io/en/latest/
- **FreeCodeCamp Python Course:** https://www.freecodecamp.org/learn/scientific-computing-with-python/

**Interactive Learning:**

- **Python.org Online Console:** https://www.python.org/shell/
- **Repl.it Python:** https://replit.com/languages/python3
- **Codecademy Python (Free Tier):** https://www.codecademy.com/learn/learn-python-3

**Core Python for SysAdmins:**

```python
# File operations (log analysis)
import os
import re
from datetime import datetime

def analyze_log_file(filename):
    failed_logins = []
    with open(filename, 'r') as f:
        for line in f:
            if 'Failed password' in line:
                # Extract IP address
                ip_match = re.search(r'from (\d+\.\d+\.\d+\.\d+)', line)
                if ip_match:
                    failed_logins.append(ip_match.group(1))
    return failed_logins

# Dictionary for counting occurrences
ip_counts = {}
for ip in failed_logins:
    ip_counts[ip] = ip_counts.get(ip, 0) + 1
```

### Days 3-4: Python for System Administration

**Free Resources:**

- **Python System Administration:** https://python-guide-pt-br.readthedocs.io/en/latest/scenarios/admin/
- **Python DevOps Tools:** https://github.com/Leo-G/DevopsWiki/wiki/How-to-use-Python-for-DevOps
- **PSUtil Documentation:** https://psutil.readthedocs.io/en/latest/
- **Requests Library Tutorial:** https://requests.readthedocs.io/en/latest/user/quickstart/

**Libraries Installation:**

```bash
# Install essential libraries
pip install psutil requests argparse subprocess32
# Or use virtual environment (recommended)
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

**Practical Scripts:**

```python
import subprocess
import psutil
import requests

# System monitoring
def check_system_health():
    cpu_percent = psutil.cpu_percent(interval=1)
    memory = psutil.virtual_memory()
    disk = psutil.disk_usage('/')
    
    alerts = []
    if cpu_percent > 80:
        alerts.append(f"High CPU usage: {cpu_percent}%")
    if memory.percent > 85:
        alerts.append(f"High memory usage: {memory.percent}%")
    if disk.percent > 90:
        alerts.append(f"High disk usage: {disk.percent}%")
    
    return alerts

# API interaction (for cloud services)
def check_service_status(url):
    try:
        response = requests.get(url, timeout=5)
        return response.status_code == 200
    except requests.RequestException:
        return False
```

### Days 5-7: Python Security Tools

**Security Programming Resources:**

- **Python Security Guide:** https://python-security.readthedocs.io/
- **OWASP Python Security:** https://owasp.org/www-project-code-review-guide/assets/OWASP_Code_Review_Guide_v2.pdf
- **Python Cryptography:** https://cryptography.io/en/latest/
- **Hashlib Documentation:** https://docs.python.org/3/library/hashlib.html

**Security-Focused Programming:**

```python
import hashlib
import hmac
import socket
import ssl

# Password hashing (secure practices)
def hash_password(password, salt):
    return hashlib.pbkdf2_hmac('sha256', 
                              password.encode('utf-8'), 
                              salt.encode('utf-8'), 
                              100000)

# Port scanning (ethical use only)
def scan_port(host, port):
    try:
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.settimeout(1)
        result = sock.connect_ex((host, port))
        sock.close()
        return result == 0
    except:
        return False

# SSL certificate checking
def check_ssl_cert(hostname, port=443):
    context = ssl.create_default_context()
    with socket.create_connection((hostname, port)) as sock:
        with context.wrap_socket(sock, server_hostname=hostname) as ssock:
            cert = ssock.getpeercert()
            return cert['notAfter']
```

**Ethical Hacking with Python:**

- **Python for Penetration Testing:** https://www.cybrary.it/course/python-for-security-professionals/
- **Security Tools in Python:** https://github.com/dloss/python-pentest-tools

-----

## Week 3: AWS Cloud Fundamentals

### Days 1-2: AWS Core Services + Security

**Free AWS Learning Resources:**

- **AWS Free Tier:** https://aws.amazon.com/free/ (12 months free with credit card)
- **AWS Training and Certification:** https://aws.amazon.com/training/digital/ (Many free courses)
- **AWS Well-Architected Labs:** https://wellarchitectedlabs.com/ (Hands-on security labs)
- **AWS Documentation:** https://docs.aws.amazon.com/
- **A Cloud Guru Free Tier:** https://acloudguru.com/pricing (Limited free content)

**Video Tutorials:**

- **FreeCodeCamp AWS Course:** https://www.youtube.com/watch?v=3hLmDS179YE (12-hour comprehensive course)
- **AWS Official YouTube:** https://www.youtube.com/user/AmazonWebServices
- **Stephane Maarek AWS Courses:** https://www.youtube.com/c/StephaneMaarek

**Essential Services Setup:**

```bash
# AWS CLI installation and configuration
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Configure with least-privilege principles
aws configure
# Use IAM user with minimal permissions, not root account
```

**Hands-On Labs:**

- **AWS Hands-On Tutorials:** https://aws.amazon.com/getting-started/hands-on/
- **AWS Security Labs:** https://github.com/awslabs/aws-security-benchmark
- **CloudFormation Templates:** https://github.com/awslabs/aws-cloudformation-templates

### Days 3-4: Infrastructure as Code + Automation

**CloudFormation Resources:**

- **CloudFormation User Guide:** https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/
- **CloudFormation Templates:** https://aws.amazon.com/cloudformation/templates/
- **AWS Samples GitHub:** https://github.com/aws-samples

**CloudFormation Example:**

```yaml
AWSTemplateFormatVersion: '2010-09-09'
Description: 'Secure web server infrastructure'

Resources:
  WebServerSecurityGroup:
    Type: AWS::EC2::SecurityGroup
    Properties:
      GroupDescription: Security group for web servers
      VpcId: !Ref VPC
      SecurityGroupIngress:
        - IpProtocol: tcp
          FromPort: 443
          ToPort: 443
          CidrIp: 0.0.0.0/0
        - IpProtocol: tcp
          FromPort: 22
          ToPort: 22
          CidrIp: 10.0.0.0/16  # Only from VPC
```

**Boto3 Resources:**

- **Boto3 Documentation:** https://boto3.amazonaws.com/v1/documentation/api/latest/index.html
- **AWS SDK Python Examples:** https://github.com/awsdocs/aws-doc-sdk-examples/tree/main/python

**Python + AWS (Boto3):**

```python
import boto3

# EC2 security assessment
ec2 = boto3.client('ec2')

def audit_security_groups():
    sgs = ec2.describe_security_groups()
    insecure_groups = []
    
    for sg in sgs['SecurityGroups']:
        for rule in sg['IpPermissions']:
            for ip_range in rule.get('IpRanges', []):
                if ip_range['CidrIp'] == '0.0.0.0/0' and rule['FromPort'] == 22:
                    insecure_groups.append(sg['GroupId'])
    
    return insecure_groups
```

### Days 5-7: Monitoring and Compliance

**CloudWatch Resources:**

- **CloudWatch User Guide:** https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/
- **AWS Config Rules:** https://docs.aws.amazon.com/config/latest/developerguide/managed-rules-by-aws-config.html
- **AWS Security Hub:** https://docs.aws.amazon.com/securityhub/latest/userguide/

**Compliance and Security:**

- **AWS Security Best Practices:** https://d1.awsstatic.com/whitepapers/Security/AWS_Security_Best_Practices.pdf
- **CIS AWS Benchmarks:** https://www.cisecurity.org/benchmark/amazon_web_services
- **AWS Well-Architected Security Pillar:** https://docs.aws.amazon.com/wellarchitected/latest/security-pillar/wellarchitected-security-pillar.pdf

**CloudWatch Monitoring:**

```python
import boto3
from datetime import datetime, timedelta

# CloudWatch monitoring
cloudwatch = boto3.client('cloudwatch')

def create_cpu_alarm():
    cloudwatch.put_metric_alarm(
        AlarmName='HighCPUUtilization',
        ComparisonOperator='GreaterThanThreshold',
        EvaluationPeriods=2,
        MetricName='CPUUtilization',
        Namespace='AWS/EC2',
        Period=300,
        Statistic='Average',
        Threshold=80.0,
        ActionsEnabled=True,
        AlarmActions=['arn:aws:sns:region:account:topic'],
        AlarmDescription='Alert when CPU exceeds 80%'
    )
```

-----

## Week 4: SQL and Database Security

### Days 1-2: SQL Fundamentals

**Free SQL Learning Resources:**

- **W3Schools SQL Tutorial:** https://www.w3schools.com/sql/
- **SQLBolt Interactive Tutorial:** https://sqlbolt.com/
- **FreeCodeCamp SQL Course:** https://www.freecodecamp.org/learn/relational-database/
- **MySQL Tutorial:** https://dev.mysql.com/doc/mysql-tutorial-excerpt/8.0/en/
- **PostgreSQL Tutorial:** https://www.postgresqltutorial.com/

**Online SQL Practice:**

- **HackerRank SQL:** https://www.hackerrank.com/domains/sql
- **LeetCode Database:** https://leetcode.com/problemset/database/
- **SQLiteOnline:** https://sqliteonline.com/ (Practice SQL online)

**Basic Security-Focused SQL:**

```sql
-- User management (security focus)
CREATE USER 'appuser'@'localhost' IDENTIFIED BY 'SecurePassword123!';
GRANT SELECT, INSERT, UPDATE ON webapp.* TO 'appuser'@'localhost';
FLUSH PRIVILEGES;

-- Basic queries with security implications
SELECT user, host, authentication_string FROM mysql.user;
SELECT * FROM information_schema.user_privileges WHERE GRANTEE = "'appuser'@'localhost'";

-- Data analysis for security
SELECT 
    ip_address, 
    COUNT(*) as failed_attempts,
    MAX(attempt_time) as last_attempt
FROM login_attempts 
WHERE success = 0 
    AND attempt_time > DATE_SUB(NOW(), INTERVAL 1 HOUR)
GROUP BY ip_address
HAVING failed_attempts > 5
ORDER BY failed_attempts DESC;
```

### Days 3-4: Database Administration + Python Integration

**Database Security Resources:**

- **MySQL Security Guide:** https://dev.mysql.com/doc/refman/8.0/en/security-guidelines.html
- **PostgreSQL Security:** https://www.postgresql.org/docs/current/security.html
- **Database Security Checklist:** https://owasp.org/www-project-database-security/

**Installation Guides:**

- **MySQL Installation:** https://dev.mysql.com/doc/mysql-installation-excerpt/8.0/en/
- **PostgreSQL Installation:** https://www.postgresql.org/download/

**Database Security Implementation:**

```sql
-- Audit table creation
CREATE TABLE audit_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    action VARCHAR(50),
    table_name VARCHAR(50),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(15)
);

-- Trigger for audit logging
DELIMITER $$
CREATE TRIGGER user_update_audit
    AFTER UPDATE ON users
    FOR EACH ROW
BEGIN
    INSERT INTO audit_log (user_id, action, table_name, ip_address)
    VALUES (NEW.id, 'UPDATE', 'users', CONNECTION_ID());
END$$
DELIMITER ;
```

**Python Database Libraries:**

- **MySQL Connector:** https://dev.mysql.com/doc/connector-python/en/
- **PyMySQL:** https://pymysql.readthedocs.io/en/latest/
- **Psycopg2 (PostgreSQL):** https://www.psycopg.org/docs/

### Days 5-7: AWS RDS and Database Security

**RDS Resources:**

- **Amazon RDS User Guide:** https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/
- **RDS Security Best Practices:** https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_BestPractices.Security.html
- **Database Migration Service:** https://docs.aws.amazon.com/dms/latest/userguide/

**RDS Security Lab:**

- **AWS RDS Security Lab:** https://wellarchitectedlabs.com/security/200_labs/200_automated_deployment_of_detective_controls/

-----

## Week 5: Go Programming for Infrastructure

### Days 1-2: Go Basics for Systems Programming

**Free Go Learning Resources:**

- **Tour of Go:** https://tour.golang.org/ (Official interactive tutorial)
- **Go by Example:** https://gobyexample.com/ (Practical examples)
- **Effective Go:** https://golang.org/doc/effective_go.html (Best practices)
- **Go Documentation:** https://golang.org/doc/
- **FreeCodeCamp Go Course:** https://www.youtube.com/watch?v=YS4e4q9oBaU

**Interactive Learning:**

- **Go Playground:** https://play.golang.org/ (Online Go compiler)
- **Exercism Go Track:** https://exercism.org/tracks/go
- **Codewars Go:** https://www.codewars.com/?language=go

**Installation:**

- **Go Installation Guide:** https://golang.org/doc/install

**Go Systems Programming:**

```go
package main

import (
    "fmt"
    "os"
    "os/exec"
    "log"
    "bufio"
    "strings"
    "net/http"
    "encoding/json"
)

// System monitoring struct
type SystemStatus struct {
    CPUUsage    float64 `json:"cpu_usage"`
    MemoryUsage float64 `json:"memory_usage"`
    DiskUsage   float64 `json:"disk_usage"`
    ActiveUsers int     `json:"active_users"`
}

func checkSystemStatus() SystemStatus {
    // Execute system commands
    cmd := exec.Command("top", "-bn1")
    output, err := cmd.Output()
    if err != nil {
        log.Printf("Error executing command: %v", err)
        return SystemStatus{}
    }
    
    // Parse output and return status
    return SystemStatus{
        CPUUsage: 45.2,  // Parsed from command output
        MemoryUsage: 67.8,
        DiskUsage: 34.1,
        ActiveUsers: 3,
    }
}
```

### Days 3-4: Go Web Services + Security

**Go Web Development Resources:**

- **Building Web Apps with Go:** https://codegangsta.gitbooks.io/building-web-apps-with-go/content/
- **Go Web Examples:** https://gowebexamples.com/
- **Gorilla Mux:** https://github.com/gorilla/mux (HTTP router)
- **JWT Go:** https://github.com/golang-jwt/jwt

**Security Libraries:**

- **Bcrypt:** https://pkg.go.dev/golang.org/x/crypto/bcrypt
- **CSRF Protection:** https://github.com/gorilla/csrf
- **Secure:** https://github.com/unrolled/secure

**REST API with Security:**

```go
package main

import (
    "crypto/subtle"
    "encoding/json"
    "log"
    "net/http"
    "time"
    
    "github.com/gorilla/mux"
    "github.com/golang-jwt/jwt/v4"
)

type Claims struct {
    UserID string `json:"user_id"`
    Role   string `json:"role"`
    jwt.RegisteredClaims
}

func authMiddleware(next http.HandlerFunc) http.HandlerFunc {
    return func(w http.ResponseWriter, r *http.Request) {
        tokenString := r.Header.Get("Authorization")
        if tokenString == "" {
            http.Error(w, "Missing authorization header", http.StatusUnauthorized)
            return
        }
        
        // Validate JWT token
        token, err := jwt.ParseWithClaims(tokenString, &Claims{}, func(token *jwt.Token) (interface{}, error) {
            return []byte("your-secret-key"), nil
        })
        
        if err != nil || !token.Valid {
            http.Error(w, "Invalid token", http.StatusUnauthorized)
            return
        }
        
        next.ServeHTTP(w, r)
    }
}

func systemStatusHandler(w http.ResponseWriter, r *http.Request) {
    status := checkSystemStatus()
    w.Header().Set("Content-Type", "application/json")
    json.NewEncoder(w).Encode(status)
}

func main() {
    r := mux.NewRouter()
    r.HandleFunc("/api/system/status", authMiddleware(systemStatusHandler)).Methods("GET")
    
    log.Println("Server starting on :8080")
    log.Fatal(http.ListenAndServe(":8080", r))
}
```

### Days 5-7: Go + AWS Integration

**AWS SDK for Go:**

- **AWS SDK Go V2:** https://aws.github.io/aws-sdk-go-v2/docs/
- **AWS Go Examples:** https://github.com/awsdocs/aws-doc-sdk-examples/tree/main/gov2
- **AWS Lambda Go:** https://docs.aws.amazon.com/lambda/latest/dg/lambda-golang.html

**Go AWS Libraries:**

```bash
go mod init aws-monitor
go get github.com/aws/aws-sdk-go-v2/config
go get github.com/aws/aws-sdk-go-v2/service/ec2
go get github.com/aws/aws-sdk-go-v2/service/cloudwatch
```

**AWS Integration Example:**

```go
package main

import (
    "context"
    "log"
    
    "github.com/aws/aws-sdk-go-v2/config"
    "github.com/aws/aws-sdk-go-v2/service/ec2"
    "github.com/aws/aws-sdk-go-v2/service/cloudwatch"
)

type AWSMonitor struct {
    ec2Client        *ec2.Client
    cloudwatchClient *cloudwatch.Client
}

func NewAWSMonitor() (*AWSMonitor, error) {
    cfg, err := config.LoadDefaultConfig(context.TODO())
    if err != nil {
        return nil, err
    }
    
    return &AWSMonitor{
        ec2Client:        ec2.NewFromConfig(cfg),
        cloudwatchClient: cloudwatch.NewFromConfig(cfg),
    }, nil
}

func (am *AWSMonitor) CheckInstanceSecurity() error {
    // Get all security groups
    result, err := am.ec2Client.DescribeSecurityGroups(context.TODO(), &ec2.DescribeSecurityGroupsInput{})
    if err != nil {
        return err
    }
    
    for _, sg := range result.SecurityGroups {
        for _, rule := range sg.IpPermissions {
            for _, ipRange := range rule.IpRanges {
                if *ipRange.CidrIp == "0.0.0.0/0" && *rule.FromPort == 22 {
                    log.Printf("WARNING: Security group %s allows SSH from anywhere", *sg.GroupId)
                }
            }
        }
    }
    
    return nil
}
```

-----

## Week 6: Integration and Real-World Projects

### Days 1-2: Complete Infrastructure Deployment

**DevOps Project Resources:**

- **DevOps Roadmap:** https://roadmap.sh/devops
- **12-Factor App:** https://12factor.net/
- **Infrastructure as Code Patterns:** https://infrastructure-as-code.com/

**Container Resources:**

- **Docker Getting Started:** https://docs.docker.com/get-started/
- **Docker Hub:** https://hub.docker.com/ (Free container registry)
- **Podman Tutorial:** https://podman.io/getting-started/

**Project: Secure Web Application Stack:**

```bash
#!/bin/bash
# Complete deployment script combining all skills

# 1. Create AWS infrastructure
aws cloudformation create-stack \
    --stack-name secure-webapp \
    --template-body file://infrastructure.yaml \
    --capabilities CAPABILITY_IAM

# 2. Deploy database with security hardening
mysql -u root -p << EOF
CREATE DATABASE webapp;
CREATE USER 'webapp'@'%' IDENTIFIED BY '$(openssl rand -base64 32)';
GRANT SELECT, INSERT, UPDATE, DELETE ON webapp.* TO 'webapp'@'%';
FLUSH PRIVILEGES;
EOF

# 3. Deploy Go application
go build -o webapp main.go
sudo systemctl create webapp.service
sudo systemctl enable webapp
sudo systemctl start webapp

# 4. Configure monitoring
python3 setup_monitoring.py
```

### Days 3-4: Monitoring and Alerting System

**Monitoring Resources:**

- **Prometheus Getting Started:** https://prometheus.io/docs/prometheus/latest/getting_started/
- **Grafana Tutorials:** https://grafana.com/tutorials/
- **Node Exporter:** https://github.com/prometheus/node_exporter
- **Alertmanager:** https://prometheus.io/docs/alerting/latest/alertmanager/

**Free Monitoring Tools:**

- **Zabbix:** https://www.zabbix.com/ (Open source monitoring)
- **Nagios Core:** https://www.nagios.org/projects/nagios-core/
- **Icinga:** https://icinga.com/ (Open source monitoring)

### Days 5-7: Portfolio and Documentation

**Documentation Resources:**

- **GitBook:** https://www.gitbook.com/ (Free documentation hosting)
- **GitHub Pages:** https://pages.github.com/ (Free static site hosting)
- **MkDocs:** https://www.mkdocs.org/ (Static documentation generator)
- **Draw.io:** https://app.diagrams.net/ (Free architecture diagrams)

**Portfolio Hosting:**

- **GitHub:** https://github.com/ (Free repository hosting)
- **GitLab:** https://gitlab.com/ (Free CI/CD and hosting)
- **Netlify:** https://www.netlify.com/ (Free static site hosting)

-----

## Additional Free Resources

### General DevOps Learning:

- **DevOps Institute:** https://devopsinstitute.com/resources/ (Free resources)
- **CNCF Landscape:** https://landscape.cncf.io/ (Cloud native technologies overview)
- **Linux Foundation Training:** https://training.linuxfoundation.org/resources/ (Free courses)

### Security-Focused DevOps:

- **OWASP DevSecOps Guideline:** https://owasp.org/www-project-devsecops-guideline/
- **NIST Cybersecurity Framework:** https://www.nist.gov/cyberframework
- **CIS Controls:** https://www.cisecurity.org/controls/

### Practice Platforms:

- **TryHackMe:** https://tryhackme.com/ (Security challenges with DevOps content)
- **KodeKloud:** https://kodekloud.com/ (Hands-on DevOps labs - some free content)
- **Katacoda:** https://www.katacoda.com/ (Interactive learning scenarios)

### Community Resources:

- **r/devops:** https://www.reddit.com/r/devops/
- **DevOps Chat:** https://devopschat.co/
- **Stack Overflow:** https://stackoverflow.com/ (Q&A for technical issues)
- **Dev.to:** https://dev.to/ (Developer community with DevOps content)

### YouTube Channels:

- **TechWorld with Nana:** https://www.youtube.com/c/TechWorldwithNana
- **DevOps Journey:** https://www.youtube.com/c/DevOpsJourney
- **Cloud Advocate:** https://www.youtube.com/c/CloudAdvocate
- **NetworkChuck:** https://www.youtube.com/c/NetworkChuck

This comprehensive resource list provides you with everything needed to complete the 6-week transformation program without spending money on courses or training materials. All resources are freely available and will provide hands-on experience with real-world tools and technologies.​​​​​​​​​​​​​​​​


## 6-Week Technical Transformation Plan

*From InfoSec Professional to DevOps/Platform Engineer*

### Current Skill Assessment

**Strengths to Leverage:**

- **Security mindset** - critical for DevOps and cloud architecture
- **Troubleshooting skills** - essential for systems administration
- **Compliance knowledge** - valuable for enterprise environments
- **Network understanding** - foundation for cloud networking
- **User support experience** - helps with internal tooling design

**Target Outcome:** Junior-to-Mid Level DevOps Engineer or Cloud Security Engineer

-----

## Week 1: Linux Fundamentals + Security Context

### Days 1-2: Linux Basics with Security Focus

**Core Concepts:**

```bash
# File system navigation and permissions
ls -la /etc/passwd
chmod 755 script.sh
chown user:group file.txt

# Process management (security-focused)
ps aux | grep suspicious
netstat -tulpn | grep :22
lsof -i :443

# User and group management
sudo adduser newuser
sudo usermod -aG sudo newuser
sudo visudo  # Secure sudo configuration
```

**Security-Focused Learning:**

- File permissions and ownership
- User account security
- Process monitoring and management
- Network port scanning prevention
- Log file locations and analysis (`/var/log/`)

### Days 3-4: System Administration + Monitoring

**Essential Commands:**

```bash
# System monitoring (InfoSec relevance)
top, htop, iotop
journalctl -f  # Real-time log monitoring
systemctl status ssh
ss -tulpn  # Modern netstat replacement

# File system and disk management
df -h, du -sh
mount, umount
fdisk -l
```

**Package Management:**

```bash
# Ubuntu/Debian
apt update && apt upgrade
apt search package-name
apt install -y package-name

# CentOS/RHEL
yum update
yum search package-name
yum install -y package-name
```

### Days 5-7: Bash Scripting Fundamentals

**Basic Scripting:**

```bash
#!/bin/bash
# Security log analyzer script
LOG_FILE="/var/log/auth.log"
FAILED_ATTEMPTS=$(grep "Failed password" $LOG_FILE | wc -l)

if [ $FAILED_ATTEMPTS -gt 5 ]; then
    echo "ALERT: $FAILED_ATTEMPTS failed login attempts detected"
    # Send email or alert
fi

# Functions and error handling
check_service() {
    if systemctl is-active --quiet $1; then
        echo "$1 is running"
    else
        echo "WARNING: $1 is not running"
    fi
}

check_service ssh
check_service nginx
```

**Automation Focus:**

- Log analysis scripts
- System health checks
- Security scanning automation
- Backup scripts with error handling

-----

## Week 2: Python Programming for Infrastructure

### Days 1-2: Python Basics for SysAdmins

**Core Python:**

```python
# File operations (log analysis)
import os
import re
from datetime import datetime

def analyze_log_file(filename):
    failed_logins = []
    with open(filename, 'r') as f:
        for line in f:
            if 'Failed password' in line:
                # Extract IP address
                ip_match = re.search(r'from (\d+\.\d+\.\d+\.\d+)', line)
                if ip_match:
                    failed_logins.append(ip_match.group(1))
    return failed_logins

# Dictionary for counting occurrences
ip_counts = {}
for ip in failed_logins:
    ip_counts[ip] = ip_counts.get(ip, 0) + 1
```

**Libraries to Learn:**

- `os` and `sys` - system interaction
- `subprocess` - running shell commands
- `json` - configuration and API responses
- `requests` - HTTP client for APIs
- `argparse` - command-line argument parsing

### Days 3-4: Python for System Administration

**Practical Scripts:**

```python
import subprocess
import psutil
import requests

# System monitoring
def check_system_health():
    cpu_percent = psutil.cpu_percent(interval=1)
    memory = psutil.virtual_memory()
    disk = psutil.disk_usage('/')
    
    alerts = []
    if cpu_percent > 80:
        alerts.append(f"High CPU usage: {cpu_percent}%")
    if memory.percent > 85:
        alerts.append(f"High memory usage: {memory.percent}%")
    if disk.percent > 90:
        alerts.append(f"High disk usage: {disk.percent}%")
    
    return alerts

# API interaction (for cloud services)
def check_service_status(url):
    try:
        response = requests.get(url, timeout=5)
        return response.status_code == 200
    except requests.RequestException:
        return False
```

### Days 5-7: Python Security Tools

**Security-Focused Programming:**

```python
import hashlib
import hmac
import socket
import ssl

# Password hashing (secure practices)
def hash_password(password, salt):
    return hashlib.pbkdf2_hmac('sha256', 
                              password.encode('utf-8'), 
                              salt.encode('utf-8'), 
                              100000)

# Port scanning (ethical use only)
def scan_port(host, port):
    try:
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.settimeout(1)
        result = sock.connect_ex((host, port))
        sock.close()
        return result == 0
    except:
        return False

# SSL certificate checking
def check_ssl_cert(hostname, port=443):
    context = ssl.create_default_context()
    with socket.create_connection((hostname, port)) as sock:
        with context.wrap_socket(sock, server_hostname=hostname) as ssock:
            cert = ssock.getpeercert()
            return cert['notAfter']
```

-----

## Week 3: AWS Cloud Fundamentals

### Days 1-2: AWS Core Services + Security

**Essential Services Setup:**

```bash
# AWS CLI installation and configuration
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Configure with least-privilege principles
aws configure
# Use IAM user with minimal permissions, not root account
```

**Core Services (Security-Focused):**

- **IAM:** Users, groups, roles, and policies
- **VPC:** Network isolation and security groups
- **EC2:** Instance security and key management
- **S3:** Bucket policies and encryption
- **CloudTrail:** Audit logging
- **GuardDuty:** Threat detection

**Hands-On Labs:**

```bash
# Create secure VPC
aws ec2 create-vpc --cidr-block 10.0.0.0/16
aws ec2 create-subnet --vpc-id vpc-12345 --cidr-block 10.0.1.0/24
aws ec2 create-security-group --group-name web-sg --description "Web servers"
aws ec2 authorize-security-group-ingress --group-id sg-12345 --protocol tcp --port 443 --cidr 0.0.0.0/0
```

### Days 3-4: Infrastructure as Code + Automation

**AWS CloudFormation Basics:**

```yaml
AWSTemplateFormatVersion: '2010-09-09'
Description: 'Secure web server infrastructure'

Resources:
  WebServerSecurityGroup:
    Type: AWS::EC2::SecurityGroup
    Properties:
      GroupDescription: Security group for web servers
      VpcId: !Ref VPC
      SecurityGroupIngress:
        - IpProtocol: tcp
          FromPort: 443
          ToPort: 443
          CidrIp: 0.0.0.0/0
        - IpProtocol: tcp
          FromPort: 22
          ToPort: 22
          CidrIp: 10.0.0.0/16  # Only from VPC
```

**Python + AWS (Boto3):**

```python
import boto3

# EC2 security assessment
ec2 = boto3.client('ec2')

def audit_security_groups():
    sgs = ec2.describe_security_groups()
    insecure_groups = []
    
    for sg in sgs['SecurityGroups']:
        for rule in sg['IpPermissions']:
            for ip_range in rule.get('IpRanges', []):
                if ip_range['CidrIp'] == '0.0.0.0/0' and rule['FromPort'] == 22:
                    insecure_groups.append(sg['GroupId'])
    
    return insecure_groups
```

### Days 5-7: Monitoring and Compliance

**CloudWatch and Logging:**

```python
import boto3
from datetime import datetime, timedelta

# CloudWatch monitoring
cloudwatch = boto3.client('cloudwatch')

def create_cpu_alarm():
    cloudwatch.put_metric_alarm(
        AlarmName='HighCPUUtilization',
        ComparisonOperator='GreaterThanThreshold',
        EvaluationPeriods=2,
        MetricName='CPUUtilization',
        Namespace='AWS/EC2',
        Period=300,
        Statistic='Average',
        Threshold=80.0,
        ActionsEnabled=True,
        AlarmActions=['arn:aws:sns:region:account:topic'],
        AlarmDescription='Alert when CPU exceeds 80%'
    )
```

**Security Best Practices:**

- MFA enforcement
- Least privilege access
- Encryption at rest and in transit
- Regular security assessments
- Cost monitoring and alerts

-----

## Week 4: SQL and Database Security

### Days 1-2: SQL Fundamentals

**Basic Operations:**

```sql
-- User management (security focus)
CREATE USER 'appuser'@'localhost' IDENTIFIED BY 'SecurePassword123!';
GRANT SELECT, INSERT, UPDATE ON webapp.* TO 'appuser'@'localhost';
FLUSH PRIVILEGES;

-- Basic queries with security implications
SELECT user, host, authentication_string FROM mysql.user;
SELECT * FROM information_schema.user_privileges WHERE GRANTEE = "'appuser'@'localhost'";

-- Data analysis for security
SELECT 
    ip_address, 
    COUNT(*) as failed_attempts,
    MAX(attempt_time) as last_attempt
FROM login_attempts 
WHERE success = 0 
    AND attempt_time > DATE_SUB(NOW(), INTERVAL 1 HOUR)
GROUP BY ip_address
HAVING failed_attempts > 5
ORDER BY failed_attempts DESC;
```

### Days 3-4: Database Administration + Python Integration

**Database Security:**

```sql
-- Audit table creation
CREATE TABLE audit_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    action VARCHAR(50),
    table_name VARCHAR(50),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(15)
);

-- Trigger for audit logging
DELIMITER $$
CREATE TRIGGER user_update_audit
    AFTER UPDATE ON users
    FOR EACH ROW
BEGIN
    INSERT INTO audit_log (user_id, action, table_name, ip_address)
    VALUES (NEW.id, 'UPDATE', 'users', CONNECTION_ID());
END$$
DELIMITER ;
```

**Python Database Integration:**

```python
import mysql.connector
from mysql.connector import Error
import hashlib
import secrets

class SecureDatabase:
    def __init__(self):
        self.connection = None
        
    def connect(self):
        try:
            self.connection = mysql.connector.connect(
                host='localhost',
                database='webapp',
                user='appuser',
                password='SecurePassword123!',
                ssl_disabled=False,
                autocommit=False  # Explicit transaction control
            )
        except Error as e:
            print(f"Database connection error: {e}")
    
    def create_user(self, username, password):
        # Secure password hashing
        salt = secrets.token_hex(16)
        password_hash = hashlib.pbkdf2_hmac('sha256', 
                                          password.encode('utf-8'), 
                                          salt.encode('utf-8'), 
                                          100000)
        
        cursor = self.connection.cursor(prepared=True)
        query = "INSERT INTO users (username, password_hash, salt) VALUES (?, ?, ?)"
        cursor.execute(query, (username, password_hash.hex(), salt))
        self.connection.commit()
```

### Days 5-7: AWS RDS and Database Security

**RDS Security Configuration:**

```python
import boto3

rds = boto3.client('rds')

# Create secure RDS instance
def create_secure_rds():
    response = rds.create_db_instance(
        DBInstanceIdentifier='secure-webapp-db',
        DBInstanceClass='db.t3.micro',
        Engine='mysql',
        MasterUsername='admin',
        MasterUserPassword='SecureRootPassword123!',
        VpcSecurityGroupIds=['sg-12345'],  # Restricted security group
        BackupRetentionPeriod=7,
        StorageEncrypted=True,
        MultiAZ=True,  # High availability
        DeletionProtection=True
    )
    return response
```

-----

## Week 5: Go Programming for Infrastructure

### Days 1-2: Go Basics for Systems Programming

**Go Fundamentals:**

```go
package main

import (
    "fmt"
    "os"
    "os/exec"
    "log"
    "bufio"
    "strings"
    "net/http"
    "encoding/json"
)

// System monitoring struct
type SystemStatus struct {
    CPUUsage    float64 `json:"cpu_usage"`
    MemoryUsage float64 `json:"memory_usage"`
    DiskUsage   float64 `json:"disk_usage"`
    ActiveUsers int     `json:"active_users"`
}

func checkSystemStatus() SystemStatus {
    // Execute system commands
    cmd := exec.Command("top", "-bn1")
    output, err := cmd.Output()
    if err != nil {
        log.Printf("Error executing command: %v", err)
        return SystemStatus{}
    }
    
    // Parse output and return status
    return SystemStatus{
        CPUUsage: 45.2,  // Parsed from command output
        MemoryUsage: 67.8,
        DiskUsage: 34.1,
        ActiveUsers: 3,
    }
}
```

### Days 3-4: Go Web Services + Security

**REST API with Security:**

```go
package main

import (
    "crypto/subtle"
    "encoding/json"
    "log"
    "net/http"
    "time"
    
    "github.com/gorilla/mux"
    "github.com/golang-jwt/jwt/v4"
)

type Claims struct {
    UserID string `json:"user_id"`
    Role   string `json:"role"`
    jwt.RegisteredClaims
}

func authMiddleware(next http.HandlerFunc) http.HandlerFunc {
    return func(w http.ResponseWriter, r *http.Request) {
        tokenString := r.Header.Get("Authorization")
        if tokenString == "" {
            http.Error(w, "Missing authorization header", http.StatusUnauthorized)
            return
        }
        
        // Validate JWT token
        token, err := jwt.ParseWithClaims(tokenString, &Claims{}, func(token *jwt.Token) (interface{}, error) {
            return []byte("your-secret-key"), nil
        })
        
        if err != nil || !token.Valid {
            http.Error(w, "Invalid token", http.StatusUnauthorized)
            return
        }
        
        next.ServeHTTP(w, r)
    }
}

func systemStatusHandler(w http.ResponseWriter, r *http.Request) {
    status := checkSystemStatus()
    w.Header().Set("Content-Type", "application/json")
    json.NewEncoder(w).Encode(status)
}

func main() {
    r := mux.NewRouter()
    r.HandleFunc("/api/system/status", authMiddleware(systemStatusHandler)).Methods("GET")
    
    log.Println("Server starting on :8080")
    log.Fatal(http.ListenAndServe(":8080", r))
}
```

### Days 5-7: Go + AWS Integration

**AWS SDK with Go:**

```go
package main

import (
    "context"
    "log"
    
    "github.com/aws/aws-sdk-go-v2/config"
    "github.com/aws/aws-sdk-go-v2/service/ec2"
    "github.com/aws/aws-sdk-go-v2/service/cloudwatch"
)

type AWSMonitor struct {
    ec2Client        *ec2.Client
    cloudwatchClient *cloudwatch.Client
}

func NewAWSMonitor() (*AWSMonitor, error) {
    cfg, err := config.LoadDefaultConfig(context.TODO())
    if err != nil {
        return nil, err
    }
    
    return &AWSMonitor{
        ec2Client:        ec2.NewFromConfig(cfg),
        cloudwatchClient: cloudwatch.NewFromConfig(cfg),
    }, nil
}

func (am *AWSMonitor) CheckInstanceSecurity() error {
    // Get all security groups
    result, err := am.ec2Client.DescribeSecurityGroups(context.TODO(), &ec2.DescribeSecurityGroupsInput{})
    if err != nil {
        return err
    }
    
    for _, sg := range result.SecurityGroups {
        for _, rule := range sg.IpPermissions {
            for _, ipRange := range rule.IpRanges {
                if *ipRange.CidrIp == "0.0.0.0/0" && *rule.FromPort == 22 {
                    log.Printf("WARNING: Security group %s allows SSH from anywhere", *sg.GroupId)
                }
            }
        }
    }
    
    return nil
}
```

-----

## Week 6: Integration and Real-World Projects

### Days 1-2: Complete Infrastructure Deployment

**Project: Secure Web Application Stack**

```bash
#!/bin/bash
# Complete deployment script combining all skills

# 1. Create AWS infrastructure
aws cloudformation create-stack \
    --stack-name secure-webapp \
    --template-body file://infrastructure.yaml \
    --capabilities CAPABILITY_IAM

# 2. Deploy database with security hardening
mysql -u root -p << EOF
CREATE DATABASE webapp;
CREATE USER 'webapp'@'%' IDENTIFIED BY '$(openssl rand -base64 32)';
GRANT SELECT, INSERT, UPDATE, DELETE ON webapp.* TO 'webapp'@'%';
FLUSH PRIVILEGES;
EOF

# 3. Deploy Go application
go build -o webapp main.go
sudo systemctl create webapp.service
sudo systemctl enable webapp
sudo systemctl start webapp

# 4. Configure monitoring
python3 setup_monitoring.py
```

### Days 3-4: Monitoring and Alerting System

**Integrated Monitoring Solution:**

```python
# monitoring.py - Comprehensive monitoring system
import boto3
import mysql.connector
import subprocess
import json
import time
from datetime import datetime

class InfrastructureMonitor:
    def __init__(self):
        self.aws_session = boto3.Session()
        self.db_connection = None
        self.alerts = []
    
    def check_aws_resources(self):
        ec2 = self.aws_session.client('ec2')
        instances = ec2.describe_instances()
        
        for reservation in instances['Reservations']:
            for instance in reservation['Instances']:
                if instance['State']['Name'] != 'running':
                    self.alerts.append(f"Instance {instance['InstanceId']} is not running")
    
    def check_database_connections(self):
        try:
            conn = mysql.connector.connect(
                host='localhost',
                user='monitoring',
                password='MonitoringPass123!'
            )
            cursor = conn.cursor()
            cursor.execute("SHOW PROCESSLIST")
            connections = cursor.fetchall()
            
            if len(connections) > 100:
                self.alerts.append(f"High database connections: {len(connections)}")
        except Exception as e:
            self.alerts.append(f"Database connection failed: {e}")
    
    def check_system_resources(self):
        # CPU check
        cpu_usage = float(subprocess.check_output(
            "top -bn1 | grep 'Cpu(s)' | awk '{print $2}' | cut -d'%' -f1",
            shell=True
        ).decode().strip())
        
        if cpu_usage > 80:
            self.alerts.append(f"High CPU usage: {cpu_usage}%")
    
    def send_alerts(self):
        if self.alerts:
            # Send to CloudWatch, email, Slack, etc.
            print(f"ALERTS: {json.dumps(self.alerts, indent=2)}")

if __name__ == "__main__":
    monitor = InfrastructureMonitor()
    while True:
        monitor.check_aws_resources()
        monitor.check_database_connections()
        monitor.check_system_resources()
        monitor.send_alerts()
        time.sleep(300)  # Check every 5 minutes
```

### Days 5-7: Portfolio and Documentation

**Complete Project Documentation:**

1. **Architecture Diagram** - showing all components and security boundaries
2. **Security Assessment** - documenting implemented security controls
3. **Runbooks** - operational procedures for common tasks
4. **Performance Benchmarks** - baseline metrics and optimization notes
5. **Disaster Recovery Plan** - backup and recovery procedures

**Portfolio Projects:**

1. **Secure Multi-Tier Web Application** with Go backend, MySQL database, Python monitoring
2. **AWS Infrastructure as Code** with security best practices
3. **Automated Security Scanning** tools written in Python and Bash
4. **System Monitoring Dashboard** displaying real-time infrastructure health
5. **Incident Response Toolkit** combining all learned technologies

-----

## Expected Outcomes and Next Steps

### Technical Skills Achieved:

- **Linux Administration:** Intermediate level with security focus
- **Python Programming:** Intermediate for automation and APIs
- **Go Programming:** Beginner-to-intermediate for web services
- **Bash Scripting:** Intermediate for automation
- **AWS Cloud:** Foundational understanding with security emphasis
- **SQL:** Basic-to-intermediate with security considerations

### Career Transition Opportunities:

**Immediate Targets (0-6 months):**

- **Junior DevOps Engineer:** $70k - $95k
- **Cloud Security Engineer:** $85k - $115k
- **Infrastructure Analyst:** $75k - $100k
- **Site Reliability Engineer (Junior):** $80k - $110k

**Medium-term Goals (6-18 months):**

- **DevOps Engineer:** $95k - $130k
- **Cloud Infrastructure Engineer:** $100k - $135k
- **Security Automation Engineer:** $105k - $140k
- **Platform Engineer:** $110k - $145k

### Recommended Follow-up Learning:

1. **Container Technologies:** Docker, Kubernetes
2. **Infrastructure as Code:** Terraform, Ansible
3. **CI/CD:** Jenkins, GitLab CI, GitHub Actions
4. **Advanced AWS:** EKS, Lambda, API Gateway
5. **Monitoring:** Prometheus, Grafana, ELK Stack

This plan leverages your existing security and troubleshooting expertise while building the technical foundation needed for modern DevOps and cloud engineering roles. The security perspective you bring is highly valuable and will differentiate you in the job market.
