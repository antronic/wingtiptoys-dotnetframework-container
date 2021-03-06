FROM mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-ltsc2019 AS build
WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.sln .
COPY . ./aspnetapp/
RUN nuget restore

# copy everything else and build app
COPY ./. ./aspnetapp/
WORKDIR /app/aspnetapp
RUN msbuild /p:Configuration=Release /p:VisualStudioVersion=11.0


FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019 AS runtime
WORKDIR /inetpub/wwwroot
COPY --from=build /app/aspnetapp/WingtipToys. ./
