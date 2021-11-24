*** Settings ***
Resource     ../page_objects/loginPage.resource
Library     ../python_lib/custom_keywords.py
Library    SeleniumLibrary
Library    Process

*** Variables ***
${emagUrl}                 https://www.emag.ro/
${browser}                 chrome
${addToCartButton}         css:#card_grid > div:nth-child(1) > div > div > div.card-v2-content > div.card-v2-atc.mrg-top-xxs > form > button
${cartButton}              css:body > div.ph-modal.modal.fade.product-purchased-modal.in > div > div > div.modal-body.modal-content-extra-padding.pad-sep-xs.hidden-xs > div > div.table-cell.col-xs-12.col-sm-2.col-md-2.hidden-xs.hidden-sm > a
${cartIsNotEmpty}          css:body > div.ph-modal.modal.fade.product-purchased-modal.in > div > div
${firstElementInList}      css:#card_grid > div:nth-child(1) > div > div > div.card-v2-info > div > a
${firstElementInCart}      css:#vendorsContainer > div > div.cart-widget.cart-line > div > div.main-product-details-container.emg-right > div.line-item.line-item-main > div.main-product-title-container.emg-left > a
${scrollingPixels}         250

*** Test Cases ***
Basic functionality test
    Open Browser    url=${emagUrl}    browser=${browser}
    Accept cookies
    Navigate through pages
    Execute JavaScript    window.scrollTo(0, ${scrollingPixels})
    Wait Until Keyword Succeeds    2x    2s   Sorting changes From Popular to Latest      
    ${firstItemName} =  Get Text    ${firstElementInList} 
    Click Element    ${addToCartButton} 
    Wait Until Element Is Visible    ${cartIsNotEmpty} 
    Search by    ${cartButton}
    ${nameOfItemInCart} =  Get Text  ${firstElementInCart}
    Should Be Equal    ${firstItemName}    ${nameOfItemInCart} 
    [Teardown]    Close Browser

