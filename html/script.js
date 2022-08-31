$(function () {
    function display(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }
    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;

        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
        
        $(".hladno-meni").html('')
        $(".vatreno-meni").html('')
        $(".oprema-meni").html('')

        ucitajArtikle(item)

        $('.shop-item').on('click', '#kupi', function() {
            let target = $(this).closest('.shop-item')
            let status = target.attr('id')
            let oruzije = target.find('.shop-infromacije').attr('id')
            let predmet = target.find('.shop-infromacije h2').text()
            let cena = target.find('.shop-infromacije p').text()
    
            cena = cena.substring(8, cena.length)
    
            if (status == 'weapon') {
                $.post("http://luci_ammunation/kupovina", JSON.stringify({
                    status: true,
                    predmetIme: predmet,
                    predmetHex: oruzije,
                    cenaPredmeta: cena
                }));  
            } else if (status == 'item') {
                $.post("http://luci_ammunation/kupovina", JSON.stringify({
                    status: false,
                    predmetIme: predmet,
                    predmetHex: oruzije,
                    cenaPredmeta: cena
                }));  
            }     
        })
    })

    function ucitajArtikle(item) {
        $.each(item.predmeti.Hladno, function(k,v) {
            $(".hladno-meni").append(`
            <article class="shop-item" id="${v.status}">
                <img src="./img/items/${v.slika}" alt="">
                <div class="shop-infromacije" id="${v.predmet}">
                    <h2>${v.naziv}</h2>
                    <p>Price: $${v.cena}</p>
                    <button id="kupi">Buy</button>
                </div>
            </article>`);
        })

        $.each(item.predmeti.Vatreno, function(k,v) {
            $(".vatreno-meni").append(`
            <article class="shop-item" id="${v.status}">
                <img src="./img/items/${v.slika}" alt="">
                <div class="shop-infromacije" id="${v.predmet}">
                    <h2>${v.naziv}</h2>
                    <p>Price: $${v.cena}</p>
                    <button id="kupi">Buy</button>
                </div>
            </article>`);
        })

        $.each(item.predmeti.Ostalo, function(k,v) {
            $(".oprema-meni").append(`
            <article class="shop-item" id="${v.status}">
                <img src="./img/items/${v.slika}" alt="">
                <div class="shop-infromacije" id="${v.predmet}">
                    <h2>${v.naziv}</h2>
                    <p>Price: $${v.cena}</p>
                    <button id="kupi">Buy</button>
                </div>
            </article>`);
        })

    }
    
    document.onkeyup = function(data) {
        if (data.which == 27) {
            $.post("http://luci_ammunation/exit", JSON.stringify({}));
            $(".izbornik").css('display', 'flex');
            $(".hladno-meni").css('display', 'none');
            $(".vatreno-meni").css('display', 'none');
            $(".oprema-meni").css('display', 'none');
            $("#nazad").css('display', 'none');
            return
        }
    };

    $("#hladno").click(function () {
        $(".izbornik").css('display', 'none');
        $(".hladno-meni").css('display', 'flex');
        $(".vatreno-meni").css('display', 'none');
        $(".oprema-meni").css('display', 'none');
        $("#nazad").css('display', 'block');
        return
    })

    $("#vatreno").click(function () {
        $(".izbornik").css('display', 'none');
        $(".hladno-meni").css('display', 'none');
        $(".vatreno-meni").css('display', 'flex');
        $(".oprema-meni").css('display', 'none');
        $("#nazad").css('display', 'block');
        return
    })

    $("#oprema").click(function () {
        $(".izbornik").css('display', 'none');
        $(".hladno-meni").css('display', 'none');
        $(".vatreno-meni").css('display', 'none');
        $(".oprema-meni").css('display', 'flex');
        $("#nazad").css('display', 'block');
        return
    })

    $("#nazad").click(function () {
        $(".izbornik").css('display', 'flex');
        $(".hladno-meni").css('display', 'none');
        $(".vatreno-meni").css('display', 'none');
        $(".oprema-meni").css('display', 'none');
        $("#nazad").css('display', 'none');
        return
    })
})