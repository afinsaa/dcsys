// app/javascript/packs/basic-qr-code-reader.js

import { BrowserQRCodeReader } from '@zxing/library';
import Rails from '@rails/ujs'; // Use to make an ajax post request to Rails

const codeReader = new BrowserQRCodeReader();
let resultBox = document.getElementById('result')
let loaderBox = document.getElementById('loader')
loaderBox.style.visibility = 'hidden'
codeReader
  .decodeFromInputVideoDevice(undefined, 'video')
  .then((result) => {
    let qrDataFromReader = result.text;
    loaderBox.style.visibility = 'visible'
    // Prepare a post request so it can be sent to the Rails controller
    let formData = new FormData();

    let qrCodeParams = {
      qr_data: qrDataFromReader
    };

    formData.append("qr_code_json_data", JSON.stringify(qrCodeParams));

    // Send QR code data as JSON to the 
    // qr_codes#create action using Rails ujs
    Rails.ajax({
      url: "/checkin",
      type: "post",
      data: formData,
      success: function(d, s){
        console.log(s)
        resultBox.innerHTML = "Student Found"
        loaderBox.style.visibility = 'hidden'
      },
      error: function(d, s){

        resultBox.innerHTML = "Student Not Found"
        console.log(s)
        loaderBox.style.visibility = 'hidden'

      }
    });

  })
  .catch(error => {
    console.error(error);
    console.log(error);
    if(error === PERMISSION_DENIED) {
      // Explain why you need permission and how to update the permission setting
      console.log("It's permission errorrrrrr!")
    }
  });