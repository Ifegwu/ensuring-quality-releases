# ensuring-quality-releases
### Status
####
Badge: Here
---
## Introduction
#### This Azure DevOps project provides a concise steps to deploy IaC with with terraform, which creates and deployed virtual machine, Azure AppService to host a website - FakeRestAPI.
####
![cicd-structure](https://user-images.githubusercontent.com/9282421/193436267-c34ae0da-698c-4976-ac77-8c1a6e468ac4.png)
####
### Project Dependencies ###
* Terraform
* JMeter
* Postman
* Python
* Selenium
### Prerequisites ###
* Azure Account
* Azure DevOps Account
* Azure Command Line Interface

### Steps ###
Login to your Azure account
```
az login
```
Create service principal
```
{
  "appId": "00000000-0000-0000-0000-000000000000",
  "displayName": "azure-cli-2022-08-01-12-40-16",
  "name": "http://azure-cli-20122-08-01-12-40-16",
  "password": "0000-0000-0000-0000-000000000000",
  "tenant": "00000000-0000-0000-0000-000000000000"
}
---
```
Create a config.sh file inside terraform directory, and cd into terraform dir to run it.
```
bash config.sh
```
Create an azsecret.conf which will contains variables to be uploaded and use our pipeline as group variable

Go to your local terminal and create SSH key that the VM will use to Login, A public key (id_rsa.pub) and A private key (id_rsa) will be created and save.

```
cd ~/.ssh/
```
```
ssh-keygen -t rsa -b 4096 -f az_id_rsa
```
### Azure Pipeline ###
Install Azure Pipeline Extension
####
![azurexp](https://user-images.githubusercontent.com/9282421/193436857-5e20990f-2f7d-4d33-98d0-f0d1f35c06f4.png)

- [x] Create a new Service Connection: Project Settings -> Service connections -> New service connection -> Azure Resource Manager -> Service Principal (automatics) -> Choose the subscription -> Fill the data from your azurecreds.conf file -> Name the new service connection.

- [x] Upload our azsecret.conf to Azure Devops as a Secure File: Pipelines -> Library -> Secure Files -> + Secure File -> Upload File. 
> To access the VM which Terraform creates we will need to upload a private key to the Secure Files in the Liberary.
---
![library](https://user-images.githubusercontent.com/9282421/193437063-8fd13fdc-e90f-49f1-aa5a-005184945901.png)

### Pipeline Environment Config
* Manually register the Virtual Machine for self-test runner: Pipelines -> Environments -> TEST -> Add resource -> Virtual Machines -> Linux. 
* Copy the registration script and manually ssh into the virtual machine, paste it on the terminal and run it.
```
mkdir azagent;cd azagent;curl -fkSL -o vstsagent.tar.gz https://vstsagentpackage.azureedge.net/agent/2.210.1/vsts-agent-linux-x64-2.210.1.tar.gz;tar -zxvf vstsagent.tar.gz; if [ -x "$(command -v systemctl)" ]; then ./config.sh --environment --environmentname "Test" --acceptteeeula --agent $HOSTNAME --url https://dev.azure.com/dandevops22/ --work _work --projectname 'project3-app' --auth PAT --token fz6c5gocjpkpurwl43fta7o4pewvuy55dgxag5e6v2sjnbwk6xka --runasservice; sudo ./svc.sh install; sudo ./svc.sh start; else ./config.sh --environment --environmentname "Test" --acceptteeeula --agent $HOSTNAME --url https://dev.azure.com/dandevops22/ --work _work --projectname 'project3-app' --auth PAT --token fz6c5gocjpkpurwl43fta7o4pewvuy55dgxag5e6v2sjnbwk6xka; ./run.sh; fi
```
The VM will appear in the Environment as shown below
![azurepipelines-script](https://user-images.githubusercontent.com/9282421/193437246-582be834-fdb2-494e-a136-3413192d879f.png)
![azure-env](https://user-images.githubusercontent.com/9282421/193437309-64d75f2e-bb17-4f8c-9212-7f9770ff299c.png)
---
### Terraform apply
![1a_terraform_apply](https://user-images.githubusercontent.com/9282421/193437394-ce7930d8-376d-473c-800c-138008a689a9.png)

### Deploye Azure WebApp
![deployedwebapp](https://user-images.githubusercontent.com/9282421/193437511-c0de3d86-cb51-4ca2-a37d-14f440355447.png)

![deployed-fakerestapi](https://user-images.githubusercontent.com/9282421/193437533-1257e730-c38a-45c8-9952-8754675f6b4d.png)

### Newman Intergraion Test
#### Regression test
![3b_regression_test](https://user-images.githubusercontent.com/9282421/193437573-f0d5570e-7574-432d-8505-24277d32a99a.png)

#### Validation test
![3d_validation_test](https://user-images.githubusercontent.com/9282421/193437592-23f3abc7-1681-4f56-b305-11e0f3bf95c3.png)

### Selenium UI Test
![4a_selenium_run_UI_test](https://user-images.githubusercontent.com/9282421/193437678-7fa5613c-c2c9-43c0-b425-1b1905446c8c.png)
![4b_selenium_run_UI](https://user-images.githubusercontent.com/9282421/193437686-25fd5cdc-e6d1-4e7b-a1e1-6c6840aef970.png)

#### JMeter Stress Test
![5a_jmeter_stress_test](https://user-images.githubusercontent.com/9282421/193437717-91fb36f9-9224-4cf2-9d6a-b37d02dcfd38.png)

#### JMeter Endurance Test
![5b_jmeter_endurance_test](https://user-images.githubusercontent.com/9282421/193437734-97228857-a432-4e41-b522-161167c5264b.png)

### Published Test Results
#### Regression
![published-test-result-regression](https://user-images.githubusercontent.com/9282421/193437892-5256d682-94e5-4acb-baa6-a6d0e2d4b784.png)
#### Validation
![test_runner](https://user-images.githubusercontent.com/9282421/193437815-634af131-c21a-480d-83cd-27fd11b21c97.png)

### Azure Pipeline Stages
![2c_pipeline-execution](https://user-images.githubusercontent.com/9282421/193437956-d1e80e9c-2b45-4858-aa49-7e00d19b057f.png)

#### Creating Log Analytics workspace
> Create LAW from the portal, and navigate to: Agents management > Linux server > Log Analytics agent instructions > Download and onboard agent for Linux

SSH into the VM created above (Under test) and install the OSMAgent.
```
 wget https://raw.githubusercontent.com/Microsoft/OMS-Agent-for-Linux/master/installer/scripts/onboard_agent.sh && sh onboard_agent.sh -w e39cbdbf-7d18-4869-a5f7-238cf674601d -s DJm+g7o0ukA5K8Jjjx8agmdx1vd/lJbClV5chqI8pWjFQB/H5kc075kuk1SJD6BXpgGjjnTSf1I5dtZoWknnbA== -d opinsights.azure.com
```
#### Create a new alter for the App Service
* a) From the Azure Portal go to: Home > Resource groups > "RESOURCE_GROUP_NAME" > "App Service Name" > Monitoring > Alerts
* b) Click on New alert rule
* c) Double-check that you have the correct resource to make the alert for.
* d) Under Condition click Add condition
* d) Choose a condition e.g. Http 404
* e) Set the Threshold value to e.g. 1. (You will get altered after two consecutive HTTP 404 errors)
* f) Click Done

### Create a new action group for the App Service
* a) In the same page, go to the Actions section, click Add action groups and then Create action group
* b) Give the action group a name e.g. http404
* c) Add an Action name e.g. HTTP 404 and choose Email/SMS message/Push/Voice in Action Type.
* d) Provide your email and then click OK

![alert-services](https://user-images.githubusercontent.com/9282421/193438211-def5f843-86cd-4ea3-8609-99152ba32163.png)

#### Create AppServiceHTTPLogs
Go to the App service > Diagnostic Settings > + Add Diagnostic Setting. Tick AppServiceHTTPLogs and Send to Log Analytics Workspace created on step above and Save.

> Go back to the App service > App Service Logs . Turn on Detailed Error Messages and Failed Request Tracing > Save. Restart the app service.

#### Setting up Log Analytics
Set up custom logging, in the log analytics workspace go to Settings > Custom Logs > Add + > Choose File. Select the file selenium.log > Next > Next. Put in the following paths as type Linux:

```
/var/log/selenium/selenium.log
```
#### Generate 404 page
```
https://project3app-appservice.azurewebsites.net/forbidden404
```
![404](https://user-images.githubusercontent.com/9282421/193438741-9ee2d0fc-3c4c-4676-8348-173b2e1f7153.png)

![7a_404_email](https://user-images.githubusercontent.com/9282421/193438762-3e7fa73c-caa6-4a01-86ff-865e8d24a372.png)


To query HTTP 404 Appservice logs

```
AppServiceHTTPLogs
| where _SubscriptionId has "3ca2aacf-c15c-4375-a828-0d64713c2e00"
| where ScStatus == 404

```
![7b_log_analytics](https://user-images.githubusercontent.com/9282421/193438613-0ca0aaf2-a156-4be5-b3bd-e30b40645a42.png)

### URL Used for the project
* Postman: https://dummy.restapiexample.com/api/v1/create 
* Selemium: https://www.saucedemo.com/
* Jmeter: Delpoyed webapp - https://project3app-appservice.azurewebsites.net/ (pulling down soon)

#### Helpful resources from Microsoft
* [Example setup using GitHub](https://learn.microsoft.com/en-us/azure/devops/pipelines/tasks/utility/install-ssh-key?view=azure-devops#example-setup-using-github)
* [Environment - virtual machine resource](https://learn.microsoft.com/en-us/azure/devops/pipelines/process/environments-virtual-machines?view=azure-devops)
* [Set secret variables](https://learn.microsoft.com/en-us/azure/devops/pipelines/process/variables?tabs=yaml%2Cbatch&view=azure-devops&preserve-view=true#secret-variables)
* [Design a CI/CD pipeline using Azure DevOps](https://learn.microsoft.com/en-us/azure/architecture/example-scenario/apps/devops-dotnet-webapp)
* [Create a CI/CD pipeline for GitHub repo using Azure DevOps Starter](https://learn.microsoft.com/en-us/azure/devops-project/azure-devops-project-github)
* [Create a CI/CD pipeline for Python with Azure DevOps Starter](https://learn.microsoft.com/en-us/azure/devops-project/azure-devops-project-python?WT.mc_id=udacity_learn-wwl)


