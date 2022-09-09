# Example Azure Function

This repo contains an example of an Azure TimerTriggered function built and run as a Docker container. The repository uses .NET 6.0 and the Azure Function Isolated runtime.

The project was created using:

    Azure Functions Core Tools
    Core Tools Version:       4.0.4736 Commit hash: N/A  (64-bit)
    Function Runtime Version: 4.8.1.18957

and the command:

    func init --worker-runtime dotnet-isolated --docker --target-framework "net6.0"

The Dockerfile created by this command contained some old references. Once they were updated The build works fine with .NET 6.0.

## Run using Azre Function Core tools

Simply start the function:

    func start --verbose

## Run as a container

Build and then run the container:

    docker build . --tag timer-triggered-function:0.0.4
    docker run -e AzureWebJobsStorage="$env:AzureWebJobsStorage" -it --rm timer-triggered-function:0.0.4

## REQUIREMENTS: 

In order to run Azure Functions you must have blob storage available. The simplest way is to use Azurte and run as a container. To start Azurite and enable the blob service:

    docker run --name azurite_blob -d -p 10000:10000 mcr.microsoft.com/azure-storage/azurite azurite-blob --blobHost 0.0.0.0 --blobPort 10000

To allow Docker containers to find the Azurite emulator we need to specify 'host.docker.internal', so intead of the simple [shortcut](https://docs.microsoft.com/en-us/azure/storage/common/storage-use-emulator#connect-to-the-emulator-account-using-the-shortcut) we need the following connection string:

    DefaultEndpointsProtocol=http;AccountName=devstoreaccount1;AccountKey=Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==;BlobEndpoint=http://host.docker.internal:10000/devstoreaccount1;'

I set this in my PowerShell profile so the value is always available. Then I can simply run the container:

    docker run -e AzureWebJobsStorage="$env:AzureWebJobsStorage" -it --rm timer-triggered-function:0.0.4


