FROM mcr.microsoft.com/dotnet/sdk:6.0 AS installer-env

COPY . /app
RUN cd /app && \
    mkdir -p /home/site/wwwroot && \
    dotnet publish *.csproj --output /home/site/wwwroot 

FROM mcr.microsoft.com/azure-functions/dotnet-isolated:4-dotnet-isolated6.0-slim
ENV AzureWebJobsScriptRoot=/home/site/wwwroot \
    AzureFunctionsJobHost__Logging__Console__IsEnabled=true 

COPY --from=installer-env ["/home/site/wwwroot", "/home/site/wwwroot"]