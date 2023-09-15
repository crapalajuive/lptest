
file_=lesspass_after.png
out_file_=02

source config.env

echo ${file_}
ext_="${file_##*.}"
echo ${ext_}
file_=( "${file_%.${ext_}}" )
echo ${file_}

[[ -f ${work_dir_}/01.png ]] || cp lesspass_before.png ${work_dir_}/01.png

img_org_=${work_dir_}/${file_}.${ext_}
img_new_=${work_dir_}/${out_file_}.${ext_}

[[ -f ${work_dir_}/${file_}.${ext_} ]] || cp ${file_}.${ext_} ${work_dir_}

# rectangle x0,y0 x1,y1
convert ${img_org_} \
-draw 'fill yellow rectangle 50,70 453,105' \
-fill black -pointsize ${fontsize_} -annotate +57+93 "${site_}" \
-draw 'fill yellow rectangle 50,124 453,159' \
-fill black -pointsize ${fontsize_} -annotate +57+147 "${username_}" \
-draw 'fill yellow rectangle 50,178 363,213' \
-fill red -pointsize ${fontsize_} -annotate +57+203 "< insert master password here >" \
-draw 'fill yellow rectangle 48,336 116,364' \
-fill black -pointsize $((fontsize_ - 2)) -annotate +55+357 "${length_}" \
-strokewidth 4 \
-fill "rgba( 0, 0, 0, 0 )" \
-draw 'stroke yellow rectangle 20,390 455,428' \
${img_new_}

# -fill black -pointsize 16 -annotate +55+357 "20" \

# //////////////

file_=lesspass_after_2.png
out_file_=03

echo ${file_}
ext_="${file_##*.}"
echo ${ext_}
file_=( "${file_%.${ext_}}" )
echo ${file_}

img_org_=${work_dir_}/${file_}.${ext_}
img_new_=${work_dir_}/${out_file_}.${ext_}

[[ -f ${work_dir_}/${file_}.${ext_} ]] || cp ${file_}.${ext_} ${work_dir_}

# rectangle x0,y0 x1,y1
convert ${img_org_} \
-draw 'fill yellow rectangle 50,70 453,105' \
-fill black -pointsize ${fontsize_} -annotate +57+93 "${site_}" \
-draw 'fill yellow rectangle 50,124 453,159' \
-fill black -pointsize ${fontsize_} -annotate +57+147 "${username_}" \
-draw 'fill yellow rectangle 48,336 116,364' \
-fill black -pointsize $((fontsize_ - 2)) -annotate +55+357 "${length_}" \
-strokewidth 4 \
-fill "rgba( 0, 0, 0, 0 )" \
-draw 'stroke yellow rectangle 20,390 455,428' \
-strokewidth 2 \
-fill "rgba( 255, 215, 0 , 0.9 )" \
-draw 'stroke seagreen rectangle 63,391 371,426' \
-fill green -pointsize ${fontsize_} -annotate +70+417 "< use this generated password >" \
${img_new_}

# //////////////////

cat << EOF > ${work_dir_}/index.html
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>lesspass test 1</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
  </head>
  <body>

    <h2>Steps to access ${app_} ...</h2>
    <p>
     assumes you have (should have been pre-shared with you):
    <ul>
     <li>${app_} has been installed</li>
     <li>${app_} db  file: ${site_}.kdbx</li>
     <li>${app_} key file: ${site_}.key</li>
     <li>master password</li>
    </ul>
    </p>
    <div>
    <h3>1) goto <a href="https://www.lesspass.com" target="_blank" rel="noopener noreferrer">https://www.lesspass.com</a></h3>
    <img width="${img_size_}" src="01.png" alt="01">
    </div>
    <br/>
    <div>
    <h3> 2) enter info into the form </h3>
    <svg width="${svg_width_}" height="${svg_height_}" xmlns="http://www.w3.org/2000/svg">
        <rect x="0" y="0" width="${svg_width_}" height="${svg_height_}" fill="aquamarine" />
        <foreignobject x="0" y="0" width="${svg_width_}" height="${svg_height_}">
            <body xmlns="http://www.w3.org/1999/xhtml">
             <ul>
               <li>Site: <b>${site_}</b></li>
               <li>Username: <b>${username_}</b></li>
               <li>Master Password: <b>**use your pre-shared master password**</b></li>
               <li>Length: <b>${length_}</b></li>
             </ul>
            </body>
        </foreignobject>
    </svg>
    <br/>
    <img width="${img_size_}" src="02.png" alt="02">
<div>
    <u>note:</u> keep all other options at the defaults
</div>
<div>
    when done - press <b>"Generate & Copy"</b>
</div>
    </div>
    <br/>
    <div>
    <h3> 3) start "${app_}"</h3>
    <ul>
    <li>make sure both <b>${site_}.kdbx</b> and <b>${site_}.key</b> are in the same directory</li>
    <li>then run: <b>${app_} ${site_}.kdbx</b> using the generated password as the ${app_} password</li>
    </ul>
    <img width="${img_size_}" src="03.png" alt="03">
    </div>

  </body>
</html>
EOF

