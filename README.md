# Localizer

Localizer is a pretty simple and naive `string localizer` `Xcode Source Editor Extension`.

It was developed more like a learning exercise rather that to be used in the real world.

# What does it do?

It expects a selection (e.g. you can't call the command unless you selected some text).

It then breaks apart any `String` declarations it founds by splitting the selection based off `"` and then wrap the resulting `String` inside `NSLocalizedString`.

## Example

```swift
let _ = "This is a string"
```

If we select the above line (or only the string including the `"`) and run `Localizer` we'll get the following output:

```swift
let _ = NSLocalizedString("This is a string", comment: "This is a string")
```

# TODO

- [ ] Add an option to «localize» a whole document
- [ ] Make it smart enough to detect `String`s already wrapped in `NSLocalizedString` and avoid touching them
- [ ] Improve the `String` detection (tried with `RegularExpression` but it did not work, most likely my fault and a lack of `regular-expression-fu`).

# Author
__Esteban Torres__ 

- [![](https://img.shields.io/badge/twitter-esttorhe-brightgreen.svg)](https://twitter.com/esttorhe) 
- ✉ me@estebantorr.es

## License

`Localizer` is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
