# RickAndMortyGraphQL

## Overview

This is a demo project built using SwiftUI and follows the Model-View-ViewModel (MVVM) architectural pattern. It is designed to demonstrate fetching and displaying data from the "Rick and Morty" TV series using GraphQL. The project showcases the integration of modern development practices and tools in an iOS application.

## Features

- **SwiftUI Framework**: Utilizes SwiftUI for all UI components.
- **MVVM Architecture**: Adheres to the MVVM architectural pattern to ensure code modularity and separation of concerns.
- **GraphQL Integration**: Employs GraphQL for efficient data fetching specific to the needs of the application, reducing over-fetching and under-fetching issues.
- **Apollo iOS Client**: Incorporates the Apollo iOS Client for GraphQL integration, providing strong type usage and network management.

## System Requirements

- **iOS**: Built targeting iOS 17.0 or later.
- **Xcode**: Compatible with Xcode 15.3 or newer.

## Installation

### Clone the Repository

Start by cloning the repository to your local machine. To clone the project, open a terminal and run:

```bash
git clone https://github.com/your-username/RickAndMortyGraphQL.git
cd RickAndMortyGraphQL
```

### Install Dependencies

This project uses the Apollo iOS Client, which is integrated via Swift Package Manager (SPM). Dependencies should be automatically resolved when you open the project in Xcode. If needed, you can manually fetch and update the packages in Xcode by navigating to:

```swift
File -> Swift Packages -> Update to Latest Package Versions
```

### Building the Project

Open the project in Xcode by double-clicking the `.xcodeproj` file in the project directory. Select a target device or simulator and press `Run` to build and run the project.

If building fails initially, it is likely due to the apolla CLI tool not being installed on your machine. It should ship with the respository, but if it's missing you can install it by right clicking on the RickAndMortyGraphQL target in the editor.

For information regarding this, please refer to the [Apollo Documentation](https://www.apollographql.com/docs/ios/get-started)

![Install Apolla CLI](install-apollo-xcode-plugin.png?raw=true "Install Apolla CLI")

## GraphQL Code Generation

### Configuration

GraphQL code generation is configured using the `apollo-ios-cli`. The configuration file `apollo-codegen-config.json` specifies how the Apollo tooling should generate Swift code based on GraphQL schemas and operations.

### Running Code Generation

A custom run script in the Xcode build phases is set up to trigger the Apollo iOS CLI tool. This script ensures that the GraphQL Swift code is regenerated whenever changes are made to GraphQL files. This process is automated to keep the API data types and service calls up to date with the latest schema.

To view or modify the run script:
1. Navigate to the project settings in Xcode.
2. Go to the 'Build Phases' tab.
3. Expand the 'Fetch Rick & Morty Scheme & Generate Code' section to view the script details.
