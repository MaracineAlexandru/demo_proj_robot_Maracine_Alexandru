*** Settings ***
Library    SeleniumLibrary
Library    Collections

*** Variables ***
${acceptCookies}           css:body > div.gdpr-cookie-banner.js-gdpr-cookie-banner.pad-sep-xs.pad-hrz-none.show > div > div.col-xs-12.col-sm-5.col-md-4.col-lg-3.cookie-banner-buttons > button.btn.btn-primary.js-accept.gtm_h76e8zjgoo.btn-block
${productsTab}             css:auxiliary > div > div > ul:nth-child(1) > li > div
${topElementInSorting}     css:#main-container > section.page-section.page-listing-v2 > div > div.clearfix.pad-btm-md > div.page-container > div.listing-panel.has-floating-listing-panel-footer > div.listing-panel-footer.js-head-sort-options > div > div:nth-child(2) > div.sort-control-btn-dropdown.hidden-xs > button > span.sort-control-btn-option.text-truncate 
${sortingByNewestText}     Cele mai noi
${productGaming}           css:body > div.main-container-outer > div.megamenu-container.megamenu-always-open > div > div.megamenu-list-container > ul > li:nth-child(6) > a
${playstation}             css:#emg-body-overlay > div.main-container-inner > div.emg-container > div > div.emg-clear.main-page-container > aside > ul > li:nth-child(2) > a
${console}                 css:#emg-body-overlay > div.main-container-inner > div.emg-container > div > div.emg-clear.main-page-container > aside > ul:nth-child(2) > li:nth-child(2) > a
${sortButton}              css:#main-container > section.page-section.page-listing-v2 > div > div.clearfix.pad-btm-md > div.page-container > div.listing-panel.has-floating-listing-panel-footer > div.listing-panel-footer.js-head-sort-options > div > div:nth-child(2) > div.sort-control-btn-dropdown.hidden-xs > button > span.sort-control-btn-option.text-truncate
${sortByLatest}            css:#main-container > section.page-section.page-listing-v2 > div > div.clearfix.pad-btm-md > div.page-container > div.listing-panel.has-floating-listing-panel-footer > div.listing-panel-footer.js-head-sort-options > div > div:nth-child(2) > div.sort-control-btn-dropdown.hidden-xs.active > div > ul > li:nth-child(2) > a


*** Keywords ***

Accept cookies
    Wait Until Element Is Visible    ${acceptCookies}
    Click Element    ${acceptCookies}

Search by 
    [Arguments]  ${element} 
    Wait Until Page Contains Element    ${element}
    Click Element    ${element}

Navigate through pages
    @{NavigationList} =  Create list  ${productGaming}  ${playstation}  ${console}  ${sortButton}  ${sortByLatest} 
     FOR  ${element}  IN  @{NavigationList}
         Search by  ${element}
    END

Sorting changes From Popular to Latest 
    ${topElementInSortingText} =   Get Text  ${topElementInSorting} 
    Should Be Equal    ${topElementInSortingText}    ${sortingByNewestText}