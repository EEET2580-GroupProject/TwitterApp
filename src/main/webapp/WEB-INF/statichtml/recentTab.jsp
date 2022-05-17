<div id="recent-search-tab" style="display: none">
    <div id="main-items">
        <form id="get-recent-form" method="get" action="/twitter/getRecent">
            <div class="main-ele">
                <div id="box-around-input">
                    <i id="icon" class='fa-solid fa-magnifying-glass'></i>
                    <input id="term-field" type="text" name="q-query" placeholder="Keywords">
                </div>
            </div>


        </form>
        <div>
            <div id="button-box">
                <button class="button-ele" form="get-recent-form" type="submit" >Get recent</button>
                <button id="advanced-search-button" class="button-ele"  data-toggle="modal" data-target="#exampleModal">Advanced Search</button>
            </div>
        </div>
    </div>
    <div id="nortification">
        <span id="query-label">${query}</span>
        <span>${report}</span>
    </div>
    <div class = "history-container">
        <table id="recent-history-table">
            <tr class="history-row">
                <th>Search</th>
                <th>Date</th>
                <th>Time</th>
            </tr>
        </table>
    </div>
</div>