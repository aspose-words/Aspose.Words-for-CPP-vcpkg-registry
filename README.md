# Aspose.Words for C++ vcpkg registry
This repository allows you to install the [Aspose.Words for C++](https://products.aspose.com/words/cpp/) using [vcpkg](https://www.vcpkg.io/)

## Usage

First, setup vcpkg as described [here](https://vcpkg.io/en/getting-started.html). Then, create a [vcpkg manifest file](https://vcpkg.io/en/docs/maintainers/manifest-files.html) in the same directory as your top-level `CMakeLists.txt` file. Add a dependency to `aspose-words-cpp` within this file:

```json
{
  "name": "my-app",
  "version-string": "1.0",
  "dependencies": [
      "aspose-words-cpp",
  ]
}
```

Since Aspose.Words for C++ has no official port, create a registry `vcpkg-configuration.json` file in the same directory as your top-level `CMakeLists.txt` and manifest `vcpkg.json` files. Inside, you can declare this repository as a registry:

```json
{
  "registries": [
    {
      "kind": "git",
      "repository": "https://github.com/aspose-words/Aspose.Words-for-CPP-vcpkg-registry.git",
	  "baseline": "",
      "packages": [ "codeporting-native-cs2cpp-api", "aspose-words-cpp", "aspose-words-shaping-harfbuzz-cpp" ]
    }
  ]
}
```

When you try to run `vcpkg install` on your project now, you will receive a warning similar to:

> `$.registries[0] (a git registry): missing required field 'baseline' (a baseline)`

To fix this, copy the full 40 byte SHA of the [latest commit](https://github.com/aspose-words/Aspose.Words-for-CPP-vcpkg-registry/tree/master) of this repository into the `baseline` property of your registry file. Alternatively, run the following command to acquire the 40 byte SHA:
 
```
git ls-remote https://github.com/aspose-words/Aspose.Words-for-CPP-vcpkg-registry.git master
```
 
The `CMakeListst.txt` file:
```cmake
cmake_mininum_required(VERSION 3.21 FATAL_ERROR)

set(CMAKE_TOOLCHAIN_FILE "<path_to_vcpkg>/scripts/buildsystems/vcpkg.cmake")
 
project(MyApp LANGUAGES CXX)
 
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_STANDARD_REQUIRED TRUE)

find_package(aspose-words-cpp CONFIG REQURED)

add_executable(MyApp main.cpp)
target_link_libraries(MyApp PRIVATE Aspose::Words)
```

## License

The contents of this repository are licensed under the [MIT license](https://github.com/aspose-words/Aspose.Words-for-C/blob/master/LICENSE).


[Home](https://www.aspose.com/) | [Product Page](https://products.aspose.com/words/cpp) | [Docs](https://docs.aspose.com/words/cpp/) | [Demos](https://products.aspose.app/words/family) | [API Reference](https://apireference.aspose.com/words/cpp) | [Examples](https://github.com/aspose-words/Aspose.Words-for-C) | [Blog](https://blog.aspose.com/category/words/) | [Search](https://search.aspose.com/) | [Free Support](https://forum.aspose.com/c/words) |  [Temporary License](https://purchase.aspose.com/temporary-license)