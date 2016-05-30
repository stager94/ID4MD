var floatedOptions = {
        baseClass: ".floated-labels",
        inputSelector: ".floated-labels input, .floated-labels textarea"
    };

$(function() {

    $(".floated-labels").each(function(index, block){
        $input = $("input, textarea", block);
        if ($input.val()) {
            blurInput($input);
        }
    });


    $(document).delegate(floatedOptions.inputSelector, "focus", function(e) {
        $(e.target).closest(floatedOptions.baseClass).addClass("floated focused");
    });

    $(document).delegate(floatedOptions.inputSelector, "blur", function(e) {
        $targetInput = $(e.target);
        blurInput($targetInput);
    });

    $(document).delegate("[text-area-adjust]", "keyup", function(e) {
        o = e.target;
        o.style.height = "1px";
        o.style.height = (o.scrollHeight)+"px";
    });
});

function blurInput($targetInput) {
    $targetBlock = $targetInput.closest(floatedOptions.baseClass);
    $errorBlock = $targetBlock.find("small");

    var val = $targetInput.val();

    var valid = isValidInput($targetInput);

    if (valid == true) {
        $errorBlock.remove();

        if (val != '') {
            $targetBlock.addClass("success floated");
        }
        $targetBlock.removeClass("invalid");

    } else {
        $targetBlock.addClass("invalid").removeClass("success");
        if ( $errorBlock.length > 0 ) {
            $errorBlock.text(valid);
        } else {
            $targetBlock.append("<small class='text-danger'>" + valid +"</small>");
        }
        $targetBlock.animo( { animation: "shake" } );

    }

    if (val.length == 0 && needValidatePresence($targetInput) == false) {
        $targetBlock.removeClass("floated");
        setTimeout(function() {
            $targetBlock.removeClass("invalid success");
        }, 200);
    }
    $targetBlock.removeClass("focused");
}

function isValidInput($input) {
    if ( needValidateEmail($input) ) {
        return validateEmail($input);
    } else if ( needValidatePresence($input) ) {
        return validatePresence($input);
    } else {
        return true;
    }
}

function needValidateEmail($input) {
    return ($input.attr("type") == "email");
}

function needValidatePresence($input) {
    return ($input.attr("required") != undefined)
}

function validateEmail($input) {
    var val = $input.val();
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

    if (val == '' && needValidatePresence($input) == false) {
        return true;
    } else {
        return (re.test(val) ? true : "Invalid email address (user@gmail.com)");
    }
}

function validatePresence($input) {
    var val = $input.val();
    return (val.length > 0 ? true : "required");
}
