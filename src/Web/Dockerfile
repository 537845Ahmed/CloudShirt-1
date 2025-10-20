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

# Kopieer solution en projecten
COPY ["src/Web/Web.csproj", "src/Web/"]
COPY ["src/ApplicationCore/ApplicationCore.csproj", "src/ApplicationCore/"]
COPY ["src/Infrastructure/Infrastructure.csproj", "src/Infrastructure/"]
COPY ["src/BlazorShared/BlazorShared.csproj", "src/BlazorShared/"]
COPY ["src/PublicApi/PublicApi.csproj", "src/PublicApi/"]

# Restore dependencies
RUN dotnet restore "src/Web/Web.csproj"

# Kopieer volledige codebase
COPY . .

# Build Web project
WORKDIR "/app/src/Web"
RUN dotnet build "Web.csproj" -c Release -o /app/build

# --------------------------------------
# 3. Publish stage
# --------------------------------------
FROM build AS publish
RUN dotnet publish "Web.csproj" -c Release -o /app/publish

# --------------------------------------
# 4. Runtime stage
# --------------------------------------
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENV ASPNETCORE_URLS=http://0.0.0.0:80
ENTRYPOINT ["dotnet", "Web.dll"]
