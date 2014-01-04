![alt text](https://github.com/pfinkbeiner/formguard/raw/master/assets/img/FormGuard-Logo.png "Logo FormGuard")

# FormGuard v1.0
A powerful, customizable, quick and easy jQuery plugin to validate your forms.

## Usage
Ensure you have both the jQuery Core and the script integrated.

```
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<script type="text/javascript" src="assets/js/FormGuard.js"></script>
```

Activate FormGuard

```
	<script type="text/javascript">
		$(document).ready(function(){
   		   $("form.formguard").formguard();
		});
	</script>
```

Set your validators.

```
	<input type="text" data-validate="required" placeholder="Must be filled." />
	<input type="text" data-validate="email" placeholder="Must be a valid email address." />
	
	<input type="text" name="password" data-validate="required match[passwordconfirm] min[6]" />
	<input type="text" name="passwordconfirm" data-validate="required match[password]" />
```

## Validators
Apply your validators in `data-validate=""` attribute. You can combine them however you like. For example `data-validate="required number min[7]"` validates a required number with at least seven digits.

| key | description |
| --- | ----------- |
| `required` | Field must be filled or checkbox must be checked. |
| `min[X]` | Fields value must contains at least X characters. |
| `max[X]` | Fields value may not exceed X characters. |
| `email` | Fields value must be a valid email address. |
| `number` | Fields value must be a valid number. |
| `match[name]` | Fields value must match the value of the given fields value. For usage look at the given example (password & passwordconfirm). |

_Validators list will be continuously updated…_

## Settings

| option       | type     | default  | description |
| -------------|:--------:| :-------:| ----------- |
| live		   | `boolean` | `true` | If `true` FormGuard validates each field on blur. |
| errorCls		| `string` | `'invalid'` | This class will be attached to every field which fails validation. |
| onFormError | `function` | not set | This callback fires when form validation fails. |
 
### Licence

Copyright (c) <2013> Patrick Finkbeiner <finkbeiner.patrick[at]gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
