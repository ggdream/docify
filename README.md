# Docify

<div align="center">
    <a href="https://space.bilibili.com/264346349">
        <img src="https://img.shields.io/badge/bilibili-é­ććŠć-blueviolet" alt="đ­" />
    </a>
    <a href="https://github.com/ggdream/call">
        <img src="https://img.shields.io/badge/GitHub-é­ććŠć-ff69b4" alt="đ­" />
    </a>
</div>
<div align="center">
    <img src="https://img.shields.io/badge/Platforms-Android,iOS,Web,Windows,Linux,MacOS-009688" alt="đ­" />
    <img src="https://img.shields.io/badge/Mode-Debug,Profile,Release-3949ab" alt="đ­" />
</div>

A package that can quickly build a document website.
<br/>
<br/>
<br/>

## Steps

### 1. Add the dependience and write main function

```dart
// file: lib/main.dart
import 'package:docify/docify.dart';

void main() => Docify().run();
```

### 2. Write information according to the rules

~~~yaml
# file: assets/docify/docify.yaml

name: ææçććźą
icon: logo.png
declare: æŹąèżæ„ć°èżé

center:
  - title: æ”èŻ1
    image: 'https://raw.githubusercontent.com/mocaraka/assets/main/picture/326.jpg'
    content: test1
  - title: æ”èŻ2
    image: 'https://raw.githubusercontent.com/mocaraka/assets/main/picture/330.jpg'
    content: test2

router:
  mode: history
  routes:
    - name: a
      path: test1.md
      children:
        - name: b
          path: test2.md
        - name: b
          path: test3.md
    - name: c
      path: test4.md
~~~

### 3. Prepare documentation files

~~~yaml
# dir: assets/docify/docs/
~~~

## Example
[See here](https://github.com/ggdream/docify/tree/main/example)
