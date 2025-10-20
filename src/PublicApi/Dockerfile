# --------------------------------------
# 1. Base runtime image
# --------------------------------------
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

# --------------------------------------
# 2. Build stage
# --------------------------------------
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app

# Kopieer alleen projectbestanden (voor caching)
COPY ["src/PublicApi/PublicApi.csproj", "src/PublicApi/"]
COPY ["src/ApplicationCore/ApplicationCore.csproj", "src/ApplicationCore/"]
COPY ["src/Infrastructure/Infrastructure.csproj", "src/Infrastructure/"]
COPY ["src/BlazorShared/BlazorShared.csproj", "src/BlazorShared/"]

# Restore dependencies
RUN dotnet restore "src/PublicApi/PublicApi.csproj"

# Kopieer de rest van de broncode
COPY . .

# Build PublicApi
WORKDIR "/app/src/PublicApi"
RUN dotnet build "PublicApi.csproj" -c Release -o /app/build

# --------------------------------------
# 3. Publish stage
# --------------------------------------
FROM build AS publish
RUN dotnet publish "PublicApi.csproj" -c Release -o /app/publish

# --------------------------------------
# 4. Runtime stage
# --------------------------------------
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
# Belangrijk: bind Kestrel aan alle netwerken
ENV ASPNETCORE_URLS=http://0.0.0.0:80
ENTRYPOINT ["dotnet", "PublicApi.dll"]
