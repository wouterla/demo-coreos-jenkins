# demo-coreos-jenkins

Demo project that:
- Creates a delivery pipeline in Jenkins, using Jenkins Job Builder
- Demonstrates running jenkins (and jjb) in a docker container within coreos
- Deploys a demo java project in coreos
- Shows a simple dynamic loadbalancer (vulcan) setup implementing blue/green deployment 

It builds from the base in [this project](https://github.com/wouterla/workshop-docker-jenkins) where the readme 
contains a lot more help.

Presentation showing the highlights can be found on [slideshare](http://www.slideshare.net/wouterla/demo-coreosjenkins)
