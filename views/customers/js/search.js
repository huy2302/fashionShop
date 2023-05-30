var searchBtn = document.getElementById("headerSearch");

var searchBox = document.querySelector('.search_content');

var blur_document = document.querySelector('.blur_document')

var searchValue = "";

searchBtn.onkeyup = function () {
    if (searchBtn.value != '') {
        searchBox.classList.add('active');
    } else {
        searchBox.classList.remove('active');
    }

    searchValue = searchBtn.value;
    getSeacrh(searchValue);

    blur_document.classList.add('active_blur');
}
// click ra ngoài để tắt bảng tìm kiếm
blur_document.addEventListener('click', () => {
    document.getElementById('list_search_id').innerHTML = "";
    searchBox.classList.remove('active');
    document.getElementById('blur_document').classList.remove('active_blur');
})

var getSeacrh = function (data){
    $.ajax({
        url: '/fashionShop/controllers/getSearchBox.asp',
        data: {ID_product: data},
        dataType: 'json',
        success: function (response) {
            console.log(response);
            document.getElementById('list_search_id').innerHTML = "";
            if (response.length == 1) {
                document.getElementById('list_search_id').innerHTML += `
                    <h3>No product name ${data} could be found</h3>
                `
            }
            response.slice(0, 3).forEach(function(obj) {
                if (obj.id == "-1") {
                    return;
                }
                if (obj.price_sale != obj.price) {
                    document.getElementById('list_search_id').innerHTML += `
                    <li data-pre="VisualSearchProduct">
                        <a class="product-search" id="VisualSearchProduct-0" data-pre="ILink" href="product_ex.asp?product=${obj.id}" data-type="visualSearchItemClick" data-path="14253934" data-var="vsProduct" tabindex="0">
                            <figure class="pre-l-vs-product-card.d-sm-ib">
                                <div class="pre-l-vs-card-placeholder vs-img-loaded"><img src="/fashionShop/resources/imgProduct/${obj.image}" alt="Nike Air Force 1 '07 FlyEase" data-var="vsProductImg"></div>
                            </figure>
                            <figcaption class="va-sm-m mt3-sm mb8-sm mb0-lg prl3-sm pl0-lg pr3-lg body-3">
                                <h4 class="u-bold">${obj.name}</h4>
                                <p class="text-color-secondary">${obj.species}</p>
                                <div>
                                    <p style="text-decoration: line-through;opacity:0.5;" class="pre-vs-price u-bold pt3-sm">$${obj.price}.00</p>
                                    <p style="color: red;" class="pre-vs-price u-bold pt3-sm">$${obj.price_sale}.00</p>
                                </div>
                            </figcaption>
                        </a>
                    </li>
                    `;
                } else {
                    document.getElementById('list_search_id').innerHTML += `
                    <li data-pre="VisualSearchProduct">
                        <a class="product-search" id="VisualSearchProduct-0" data-pre="ILink" href="product_ex.asp?product=${obj.id}" data-type="visualSearchItemClick" data-path="14253934" data-var="vsProduct" tabindex="0">
                            <figure class="pre-l-vs-product-card.d-sm-ib">
                                <div class="pre-l-vs-card-placeholder vs-img-loaded"><img src="/fashionShop/resources/imgProduct/${obj.image}" alt="Nike Air Force 1 '07 FlyEase" data-var="vsProductImg"></div>
                            </figure>
                            <figcaption class="va-sm-m mt3-sm mb8-sm mb0-lg prl3-sm pl0-lg pr3-lg body-3">
                                <h4 class="u-bold">${obj.name}</h4>
                                <p class="text-color-secondary">${obj.species}</p>
                                <div>
                                    <p class="pre-vs-price u-bold pt3-sm">$${obj.price}.00</p>
                                </div>
                            </figcaption>
                        </a>
                    </li>
                    `;
                }
            });
            
            
        },
        error: function (response){
            alert('Lỗi AJAX');
        }
    });
}
