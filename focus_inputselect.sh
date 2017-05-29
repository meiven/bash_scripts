#!/bin/bash

for f in $(find -name "act_input_select.js"); do

	sed -e 's/onkeypress="return justNumbers(event)/onkeypress="justNumbers(event, this)/' -e "s/function justNumbers(e).*/function justNumbers(e, obj){\n\n\tif (e.keyCode == 13){\n\t\tif (\$('#comprobar').attr('animar') ){\n\t\t\t\$('#comprobar').trigger('click');\n\t\t} else {\n\t\t\tvar tabindex = \$(obj).attr('tabindex');\n\t\t\ttabindex++;\n\t\t\t\$('\[tabindex=' + tabindex + '\]').focus();\n\t\t}\n\t\treturn;\n\t}\n/" -e "s/function check(e).*/function check(e){\n\n\tif (e.keyCode == 13) return;/" $f > act_input_select.js 

	dirobjetivo="$(dirname "$f")"
	rm -rf "$f"
	mv -fv act_input_select.js "$dirobjetivo"

	echo -e "\n\n\$(window).bind('keydown', function(e){ if (e.keyCode == 13 && \$('#comprobar').attr('animar')) \$('#comprobar').trigger('click'); });" >> $f

done