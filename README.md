# fhiraas-microservice-kubernetes

A Quick way to invite the InterSystems FHIR Accelerator Service to your Microservice party in a Kubernetes Cluster for immediate use.  The solution uses [Nginx](https://nginx.org/en/) proxy ninja moves to get the job done.

## Prerequisites

You'll need a couple of things if you want to deploy this in the manner it was presented in the community post. Its mainly positioned as a starting point or an approach for those wishing to plug FHIR capability in quickly for development, I cut a lot of corners with secrets etc but wanted feedback on the approach in return for the effort not a masterclass on secret management.

> 🔥 Environment
> 
> For this demonstration we are parked directly onto a Kubernetes Master Node tainted to put in work.

![Environment](assets/shell_env.png?raw=true "Environment")

## FHIR up the FHIR Accelerator Service

- [ ] [Create a account in the InterSystems Cloud ](https://gitlab.com/-/experiment/new_project_readme_content:08628bec7a790d72f5f9d5aabd50d2f3?https://docs.gitlab.com/ee/user/project/repository/web_editor.html#create-a-file) 
- [ ] [Create a FHIR Accelerator Service Deployment](https://gitlab.com/-/experiment/new_project_readme_content:08628bec7a790d72f5f9d5aabd50d2f3?https://docs.gitlab.com/ee/gitlab-basics/add-file.html#add-a-file-using-the-command-line) 
- [ ] [Create an Api Key](https://gitlab.com/-/experiment/new_project_readme_content:08628bec7a790d72f5f9d5aabd50d2f3?https://docs.gitlab.com/ee/gitlab-basics/add-file.html#add-a-file-using-the-command-line)

> 🖇 Record the Endpoint and API Key
> 
> This is all we need from the FHIR Accelerator, we will interact with the service in our own way inside the Kubernetes Cluster.

## Clone this Repo
For the "Rest of the README", park yourself on a Tainted Kubernetes Master Node.  

```
git clone https://gitlab.com/isc_cloud/fhiraas-microservice-kubernetes.git
cd fhir-microservice-kubernetes
```
![Clone Repo](assets/repo_clone.png?raw=true "Ron")
## Deploy to Kubernetes Cluster

- [ ] [Create a Namespace](https://gitlab.com/isc_cloud/fhiraas-microservice-kubernetes/-/blob/main/k8s/fhiraas_k8s_deployment.yml#L1-6), this gives us a blast radius to play in for now.
- [ ] [Create a ConfigMap](https://gitlab.com/isc_cloud/fhiraas-microservice-kubernetes/-/blob/main/k8s/fhiraas_k8s_deployment.yml#L7-29), this is actually the reverse proxy madness implemented in the nginx.conf.

>  ✏ WE GOTTA EDIT SOMETHING HERE
> 
> Remember the key and endpoint we generated from the FHIR Accelerator Service?.  We need to update them [here, in the deployment](https://gitlab.com/isc_cloud/fhiraas-microservice-kubernetes/-/blob/main/k8s/fhiraas_k8s_deployment.yml#L24-26)

- [ ] [Create a Deployment](https://gitlab.com/isc_cloud/fhiraas-microservice-kubernetes/-/blob/main/k8s/fhiraas_k8s_deployment.yml#L30-60), here is the containers themselves, with a Three's Company starting point for a replica set.
- [ ] [Create a Service](https://gitlab.com/isc_cloud/fhiraas-microservice-kubernetes/-/blob/main/k8s/fhiraas_k8s_deployment.yml#L61-75), Expose it!, this is a simple NodePort service that binds a port on the Node to access the FHIR Accelerator Service.  It exposes 30036 to the node, and forwards to the deployment pod on 52773.

```
cd fhir-microservice-kubernetes # should already be here, but just to be sure.
kubectl apply -f k8s/
```
![Deploy](assets/k8s_deploy.png?raw=true "Ron")
![Deploy](assets/fhiraas_deployment.gif?raw=true "Ron")

## Test It!

Lets do a quick test and see if FHIR is successfully getting served up through the NodePort.

 - [✔] Node Port Socket Listening?
 - [✔] Conformance Statement Responding?
 - [✔] Query Patients?
 - [✔] Get Patient? 

![Test](assets/fhiraas_nodeport.gif?raw=true "Ron")


## Scale It!

We're on a single node and exposing the service to a node port so not sure this will increase our throughput, but go nuts and scale away anyway.  

```
kubectl scale deployments/isc-fhiraas-deployment --replicas=30 -n isc-fhiraas
```
![Scale](assets/scale_out.png?raw=true "Ron")
![Scale](assets/fhiraas_scalout.gif?raw=true "Ron")
## Throw some FHIR at it!
Included in this repo is a hostile, rustic, shell script for throwing some random patients into the Patient resource with a few bells and no whistles.  I needs some environment variables or you can just edit the variables directly in the script.  When running this script, ensure proper cpu fan operation and move objects from laptop area to prevent shuffling of objects in the event your laptop takes off.

```
bash bin/fhirbench.sh
```
![Deploy](assets/fhiraas-benchanddescale.png?raw=true "Ron")

> 🏆 Results
> 
> 50 puts, and 50 searches in 13 seconds.

# Blame
This stuff in the repo, Ron Sweeney (ron.sweeney@integrationrequired.com) of [Integration Required](https://www.integrationrequired.com).  These are the opinions of my employer.



