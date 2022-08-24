## v0.7.0 (2022-08-xx)

 - Upgraded to Heroicons v2.0.4
 - introduce `"mini"` type for `20x20` icons (`solid` and `outline` are `24x24`)
 
## v0.6.0 (2022-01-13)

- Upgraded to Phoenix HTML v3.2
- Upgraded to Phoenix LiveView v0.17
- Upgraded to Surface v0.7

## v0.5.1 (2021-11-16)

- Added helper function `types/0` for listing available icon types
- Added helper function `names/0` for listing available icon names

## v0.5.0 (2021-10-21)

- Upgraded to Surface v0.6.0
- Removed support for Phoenix HTML v2

## v0.4.2 (2021-09-25)

- Upgraded to Heroicons v1.0.4

## v0.4.1 (2021-09-07)

- Removed `IO.inspect`

## v0.4.0 (2021-09-05)

- Upgraded to Phoenix HTML v3.0
- Upgraded to Phoenix LiveView v0.16
- Upgraded to Surface v0.5.2

#### Breaking Changes

- Renamed `Heroicons.Components.Icon` to `Heroicons.Surface.Icon`

#### Enhancements

- Added support for heex templates with a new Phoenix LiveView component `Heroicons.LiveView.icon`

## v0.3.1 (2021-09-03)

- Added support for Phoenix HTML v0.3

## v0.3.0 (2021-06-18)

#### Breaking Changes

- Upgraded to Surface v0.5.0

## v0.2.0 (2021-06-07)

#### Breaking Changes

- Replaced `icon/3` with `icon/2`, the `type` argument should be passed as an option instead

#### Enhancements

- Added `:type` to config for setting the default icon type

## v0.1.4 (2021-05-29)

- All options passed to `icon/3` will be added to the SVG tag as HTML attributes
- Added `opts` prop to the Surface Icon component, which will be added to the SVG tag as HTML attributes

## v0.1.3 (2021-05-24)

- Improved documentation

## v0.1.2 (2021-05-22)

- Fixed Surface Icon component error when not passing the class prop

## v0.1.1 (2021-05-19)

- Added Surface Icon component

## v0.1.0 (2021-05-19)

- Initial release
