# Home lab K8S
## _Repo to host chart deployed in k8s home lab_

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

Hosting a K8S cluster at home is annoying. 
This repo contains different tools/part to deploy charts on k8s cluster + doing some automation using ansible
Tecks:
- Task
- helm
- ansible
- vendir
- ytt

## Ansible
Prerequisites:

    $ pip install ansible

Configuration:

    Modify the hosts file to include the target hosts' information and group them appropriately.
    Customize the variables in group_vars/ or host_vars/ directory as per your deployment requirements.

Running the Playbook:

    ansible-playbook infra-setup.yaml -i hosts

## Helm
We use task automation to get helm charts, configure them, overrite certain values or add k8s objects to specific chart.
The repo is composed on config folder where we use vendir to get the upstream charts, the charts directory where we overrite the values yaml file and also deploy other specific objects.
The folder structure inside the charts directory for each deployment should contains a folder called k8s if an object should be added.

The taskfile conatins these steps: 

* delete_chart:            Delete chart
* deploy:                  Deploy a Helm chart
* deploy_chart:            Deploy a Helm chart
* deploy_custom:           deploy custom k8s resources
* generate_and_sync:       Generate and sync files using vendir and ytt
* remove_namespace:        remove namespace
* uninstall:               uninstall a Helm chart
* upgrade:                 Deploy a Helm chart
* upgrade_chart:           upgrading an existing chart ${CHART_NAME}/${CHART_NAME}
* validate_chart:          Validate a Helm chart

### Usage
#### Add a chart

Use the vendir.ytt.yaml file to add a helm chart that will be deployed

    - name: openebs
      helmChart:
        name: openebs
        version: 3.7.0
        repository:
          url: https://openebs.github.io/charts
then use task file as follow:

    task generate_and_sync

To modify the helm values create a folder inside the `charts` directory with the same name as the upstream chart downloaded in the `config` directory and create the `values.yaml` file.
Deploy the chart using:

    CHART_NAME=<chart_directory_name> DEFAULT=<chart_base_name> task deploy
    CHART_NAME=hashicorp DEFAULT=hashicorp/vault  task deploy
    
To remove or upgrade a chart use:

    CHART_NAME=kube-prometheus-stack DEFAULT=prometheus-community/kube-prometheus-stack task upgrade
    CHART_NAME=kube-prometheus-stack DEFAULT=prometheus-community/kube-prometheus-stack task uninstall

#### Examples  

##### Keycloak
'''
CHART_NAME=keycloak DEFAULT=bitnami/keycloak  task upgrade_chart
CHART_NAME=keycloak DEFAULT=bitnami/keycloak  task deploy
'''
##### openebs
'''
CHART_NAME=openebs DEFAULT=openebs/openebs  task deploy
'''
##### vault
'''
CHART_NAME=hashicorp DEFAULT=hashicorp/vault  task deploy
CHART_NAME=hashicorp DEFAULT=hashicorp/vault  task uninstall
'''
##### metallb
'''
CHART_NAME=metallb-system DEFAULT=metallb/metallb  task deploy
'''
##### cert manager
CHART_NAME=cert-manager DEFAULT=cert-manager/cert-manager task deploy

##### ingress 
CHART_NAME=ingress-nginx DEFAULT=ingress-nginx/ingress-nginx task deploy

##### gitlab 
CHART_NAME=gitlab DEFAULT=gitlab/gitlab task deploy

##### s3 minio
CHART_NAME=minio DEFAULT=bitnami/minio task deploy 
##### postgers
 CHART_NAME=postgresql DEFAULT=bitnami/postgresql  task deploy

##### semaphore
CHART_NAME=semaphore DEFAULT=semaphore-light/semaphore  task deploy