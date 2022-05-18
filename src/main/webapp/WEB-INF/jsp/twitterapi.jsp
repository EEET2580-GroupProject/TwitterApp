<!DOCTYPE html>
<html>
<head>
    <title>Twitter Api Test</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    <script type="module" src="https://cdn.jsdelivr.net/npm/chart.js">
    </script>
    <script type="module" src="https://cdn.jsdelivr.net/npm/chartjs-chart-wordcloud">
    </script>

    <script>
        var myChart = null;
        var myChart2 = null;
        var myChart3 = null;
        var myChart4 = null;
        var currentPage = 0;

        function destroyChart(chartID, type){
            switch (chartID){
                case "myChart":
                    if(myChart != null){
                        myChart.destroy();
                        if(type === "table") {
                            document.getElementById("chart-container1").innerHTML = "";
                        }else{
                            document.getElementById("chart-container1").innerHTML='<canvas id="myChart"></canvas>';
                        }
                        let tb = document.getElementById("chart1-table");
                        while(tb.rows.length > 0){
                            tb.deleteRow(0);
                        }
                    }
                    break;
                case "myChart2":
                    if(myChart2 != null){
                        myChart2.destroy();

                        if(type === "table") {
                            document.getElementById("chart-container2").innerHTML = "";
                        }else{
                            document.getElementById("chart-container2").innerHTML='<canvas id="myChart2"></canvas>';
                        }

                        let tb = document.getElementById("chart2-table");
                        while(tb.rows.length > 0){
                            tb.deleteRow(0);
                        }
                    }
                    break;
                case "myChart3":
                    if(myChart3 != null){
                        myChart3.destroy();
                        if(type === "table") {
                            document.getElementById("chart-container3").innerHTML = "";
                        }else{
                            document.getElementById("chart-container3").innerHTML='<canvas id="myChart3"></canvas>';
                        }
                        let tb = document.getElementById("chart3-table");
                        while(tb.rows.length > 0){
                            tb.deleteRow(0);
                        }
                    }
                    break;
                case "myChart4":
                    if(myChart4 != null){
                        myChart4.destroy();
                        if(type === "table") {
                            document.getElementById("chart-container4").innerHTML = "";
                        }else{
                            document.getElementById("chart-container4").innerHTML='<canvas id="myChart4"></canvas>';
                        }
                        let tb = document.getElementById("chart4-table");
                        while(tb.rows.length > 0){
                            tb.deleteRow(0);
                        }
                    }
                    break;
            }
        }


        function drawChart(labels, values, chartType, chartID) {

            const data = {
                labels: labels,
                datasets: [{
                    backgroundColor: randomColors(labels.length),
                    borderColor: 'rgb(255, 99, 132)',
                    color: randomColors(labels.length),
                    data: values,
                }]
            };

            const config = {
                type: chartType,
                data: data,
                options: {
                    responsive:true,
                    maintainAspectRatio: true
                }
            };

            switch(chartID){
                case "myChart":
                    myChart = new Chart(
                        document.getElementById(chartID),
                        config
                    );
                    break;
                case "myChart2":
                    myChart2 = new Chart(
                        document.getElementById(chartID),
                        config
                    );
                    break;
                case "myChart3":
                    myChart3 = new Chart(
                        document.getElementById(chartID),
                        config
                    );
                    break;
                case "myChart4":
                    myChart4 = new Chart(
                        document.getElementById(chartID),
                        config
                    );
                    break;
            }
        }



        function randomColors(labelCount){
            let colorArray = [];
            for(let i =0; i < labelCount;i++){
                let randomColor = "#000000".replace(/0/g,function(){return (~~(Math.random()*16)).toString(16);});
                colorArray.push(randomColor);
            }
            return colorArray;
        }


        function drawFrequency(frequency, chartType, chartID){
            try {
                let data = ${data};
                let labels = [];
                let values = [];

                let domainArrayLength = data[frequency].length;
                for (let i = 0; i < domainArrayLength; i++) {
                    let name = Object.keys(data[frequency][i].attribute);
                    labels.push(name[0]);
                    let label = name[0];
                    values.push(data[frequency][i].attribute[label]);
                }
                drawChart(labels, values, chartType, chartID)

            }catch(err){
                console.log(err);
            }
        }

        function insertChartTable(dataType,tableID){
            let table = document.getElementById(tableID);
            let row = table.insertRow(0);
            let nameCell = row.insertCell(0);
            let frequencyCell = row.insertCell(1);
            nameCell.innerHTML = dataType.charAt(0).toUpperCase() + dataType.slice(1);
            frequencyCell.innerHTML = "Frequency";

            let data = ${data};
            for(let i = 0; i < data[dataType].length; i++){
                let dataRow = table.insertRow(-1);
                let nameCell = dataRow.insertCell(0);
                let frequencyCell = dataRow.insertCell(1);
                let name = Object.keys(data[dataType][i].attribute);
                nameCell.innerHTML = name[0];
                let label = name[0];
                frequencyCell.innerHTML = data[dataType][i].attribute[label];
            }

        }

        function selectChart(dataType, value, chartId, tableID){
            if(value === "raw"){
                destroyChart(chartId,"table");
                insertChartTable(dataType, tableID);
            }else{
                destroyChart(chartId,"chart")
                drawFrequency(dataType, value, chartId);
            }
            //let dropDown = document.getElementById(dropId);
        }

        function insertNewRow(id,content,dateTime,like,reply,retweet){
            let table = document.getElementById("tweet_table");
            let row = table.insertRow(-1);
            let idCell = row.insertCell(0);
            let contentCell = row.insertCell(1);
            let dateTimeCell = row.insertCell(2)
            let likeCell = row.insertCell(3);
            let replyCell = row.insertCell(4);
            let retweetCell = row.insertCell(5);
            idCell.innerHTML = id;
            contentCell.innerHTML = content;
            contentCell.className = "content_cell";
            dateTimeCell.innerHTML = dateTime;

            //likeCell.innerHTML = like;

            let data = ${data};
            maxLike = data.max_metrics.max_like;
            likePercentage = Math.floor((like/ maxLike) *100);

            maxReply = data.max_metrics.max_reply;
            replyPercentage = Math.floor((reply/ maxReply) *100);

            maxRetweet = data.max_metrics.max_retweet;
            retweetPercentage = Math.floor((retweet/ maxRetweet) *100);

            likeCell.innerHTML = '<div class="percent">'+
                '<div class="bar" style="background-color: cornflowerblue; height:10px; width:'+likePercentage +'%;"'+
                ' style="padding-top: 10px"></span>'+
                '</div>'+
                '</div>';

            replyCell.innerHTML = '<div class="percent">'+
                '<div class="bar" style="background-color: cornflowerblue; height:10px; width:'+replyPercentage +'%;"'+
                ' style="padding-top: 10px"></span>'+
                '</div>'+
                '</div>';
            retweetCell.innerHTML = '<div class="percent">'+
                '<div class="bar" style="background-color: cornflowerblue; height:10px; width:'+retweetPercentage +'%;"'+
                ' style="padding-top: 10px"></pan>'+
                '</div>'+
                '</div>';


            //replyCell.innerHTML = reply;
            //retweetCell.innerHTML = retweet;
        }

        function pagination(){
            let pre = currentPage -1;
            let pagination = '<nav>'+
                '<ul id="page-list" class="pagination justify-content-center">'+
                '<li class="page-item">'+
                '<a class="page-link" onclick="dynamicTableInsert('+ pre +',\'add\')" tabindex="-1">Previous</a>'+
                '</li>'+
                '</ul>'+
                '</nav>';
            document.querySelector("#tweet-pagination").innerHTML = pagination;

            let data = ${data};
            let dataSize = data.sorted_tweet.length;
            let pageNum = (dataSize / 10) + 1;

            var ul = document.querySelector("#page-list");
            for(let i = 0; i < pageNum-1; i++){
                let li = document.createElement("li");
                li.innerHTML = '<a class="page-link" onclick="dynamicTableInsert('+i+',\'index\')">'+i+'</a>';
                ul.appendChild(li);
            }
            let next = currentPage +1;
            let li = document.createElement("li");
            li.innerHTML = '<li class="page-item">'+
                '<a class="page-link" onclick="dynamicTableInsert('+ next +',\'add\')" >Next </a>'+
                '</li>';
            ul.appendChild(li);
        }

        function tweetTable(){
            let table = "<table id='tweet_table'> <tr>" +
            "<th>Tweet Id</th>"+
            "<th>Content</th>"+
            "<th>Date Time</th>"+
            "<th>Like</th>"+
            "<th>Reply</th>"+
            "<th>Retweet</th>"+
            "</tr>"+
            "</table>";
            document.querySelector("#tweets").innerHTML = table;

            dynamicTableInsert(0);
        }

        function dynamicTableInsert(index,type){
            try{

                let data = ${data};
                let dataSize = data.sorted_tweet.length;
                let pageNum = Math.floor((dataSize / 10)) + 1;
                let tempIndex = index;
                let start =0;
                let end = 0;
                if(type === "add"){
                    currentPage = currentPage + (tempIndex);
                    index = currentPage;

                }

                if(index < 0){
                    index = 0;
                    currentPage =0;
                }
                if(index > pageNum-1){
                    index = pageNum-1;
                    currentPage = pageNum-1;
                }
                //console.log(index);
                start = index*10;
                end = index*10 + 10;
                if(end > dataSize){
                    end = index*10 + (dataSize % 10);
                }

                let tb = document.querySelector("#tweet_table");
                while(tb.rows.length > 1){
                    tb.deleteRow(1);
                }

                for(let i = start; i < end; i++){
                    let id = data.sorted_tweet[i].id;
                    let content = data.sorted_tweet[i].text;
                    let dateTime = data.sorted_tweet[i].created_at;
                    let likeCount = data.sorted_tweet[i].public_metrics.like_count;
                    let replyCount = data.sorted_tweet[i].public_metrics.reply_count;
                    let retweetCount = data.sorted_tweet[i].public_metrics.retweet_count;
                    insertNewRow(id,content,dateTime,likeCount,replyCount,retweetCount);
                }
            }catch (err){

            }
        }


        document.addEventListener("DOMContentLoaded", function (){
            console.log(${data});
            //drawFrequency("entity_frequency", 'wordCloud', 'myChart');
            tweetTable();
            drawFrequency('entity_frequency','doughnut', 'myChart2');
            drawFrequency('hashtag_frequency', 'polarArea', 'myChart3');
            drawFrequency('mention_frequency', 'polarArea', 'myChart4');
            drawFrequency('domain_frequency', 'radar', 'myChart');
            pagination();
        })

    </script>

    <style>
        .chart{
            min-width: 350px;
        }
        table,th, td {
            border: 1px solid;
            border-collapse: collapse;
        }
        #tweet_table{
            width: 80vw;
        }

        .chart-table{
            table-layout:fixed;
            width:100%;
        }
        td{
            max-width: 500px;
            overflow:hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .percent {
            width: 100%;
            background-color: grey;
        }
        .canvas-container{
            overflow: auto;
            max-height: 500px;
        }
    </style>

</head>
<body>
    <header class="imageheader">
        <jsp:include page="../statichtml/header.jsp"/>
    </header>
    <main>
        <section id="analysis-container">
            <div id="charts">
                <div class="row">
                    <div class="col-sm-6 col-xl-3 canvas-container">
                        <select id="mychart-dropdown" onchange="selectChart('domain_frequency',value,'myChart','chart1-table')">
                            <option value="doughnut" >Doughnut</option>
                            <option value="polarArea"> Polar Area</option>
                            <option value="radar">Radar</option>
                            <option value="wordCloud">WordCloud</option>
                            <option value="raw">Raw</option>
                            <option selected hidden>Select chart</option>
                        </select>
                        <table id="chart1-table" class="chart-table"></table>
                        <div id = "chart-container1" class="chart" style="position: relative;">
                            <canvas id="myChart"></canvas>
                        </div>
                    </div>
                    <div class="col-sm-6 col-xl-3 canvas-container">
                        <select id="mychart2-dropdown" onchange="selectChart('entity_frequency',value,'myChart2','chart2-table')">
                            <option value="doughnut" >Doughnut</option>
                            <option value="polarArea"> Polar Area</option>
                            <option value="radar">Radar</option>
                            <option value="wordCloud">WordCloud</option>
                            <option value="raw">Raw</option>
                            <option selected hidden>Select chart</option>
                        </select>
                        <table id="chart2-table" class="chart-table"></table>
                        <div id = "chart-container2" class="chart" style="position: relative;">
                            <canvas id="myChart2"></canvas>
                        </div>
                    </div>
                    <div class="col-sm-6 col-xl-3 canvas-container">
                        <select id="mychart3-dropdown" onchange="selectChart('hashtag_frequency',value,'myChart3','chart3-table')">
                            <option value="doughnut" >Doughnut</option>
                            <option value="polarArea"> Polar Area</option>
                            <option value="radar">Radar</option>
                            <option value="wordCloud">WordCloud</option>
                            <option value="raw">Raw</option>
                            <option selected hidden>Select chart</option>
                        </select>
                        <table id="chart3-table" class="chart-table"></table>
                        <div id = "chart-container3" class="chart" style="position: relative;">
                            <canvas id="myChart3"></canvas>
                        </div>
                    </div>
                    <div class="col-sm-6 col-xl-3 canvas-container">
                        <select id="mychart4-dropdown" onchange="selectChart('mention_frequency',value,'myChart4','chart4-table')">
                            <option value="doughnut" >Doughnut</option>
                            <option value="polarArea"> Polar Area</option>
                            <option value="radar">Radar</option>
                            <option value="wordCloud">WordCloud</option>
                            <option value="raw">Raw</option>
                            <option selected hidden>Select chart</option>
                        </select>
                        <table id="chart4-table" class="chart-table"></table>
                        <div id = "chart-container4" class="chart" style="position: relative;">
                            <canvas id="myChart4"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <section>
            <div id="tweets">
            </div>
            <div id="tweet-pagination">
            </div>
        </section>
    </main>
</body>
</html>