
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
                let data = ${data}
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


        function drawTrackingCharts(tweetID,chartID,labels, like, reply,retweet){

            const data = {
                labels: labels,
                datasets: [
                    {
                        backgroundColor: 'red',
                        borderColor: 'red',
                        data: like,
                        label: 'Like over time',
                    },
                    {
                        backgroundColor: 'blue',
                        borderColor: 'blue',
                        data: reply,
                        label: 'Reply over time',
                    },
                    {
                        backgroundColor: 'green',
                        borderColor: 'green',
                        data: retweet,
                        label: 'Retweet over time',
                    }
                ]
            };

            const config = {
                type: 'line',
                data: data,
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            position: 'top',
                        },
                        title: {
                            display: true,
                            text: tweetID
                        }
                    },
                    scales: {
                        myScale: {
                            type: 'logarithmic',
                            position: 'left', // `axis` is determined by the position as `'y'`
                        },
                        x: {
                            grid: {
                                color: 'red',
                                borderColor: 'grey',
                                tickColor: 'grey'
                            }
                        }
                    }
                },
            };
            try {
                trackChart = new Chart(
                    document.getElementById(chartID),
                    config
                );
            }catch (err){
                trackChart.destroy()
            }
            trackChart = new Chart(
                document.getElementById(chartID),
                config
            );
        }

        function prepareTrackingJson(id,chartID){
            let content = ${oldTweets};
            let dateTime = [];
            let likeOverTime = [];
            let replyOverTime = [];
            let retweetOverTime = [];

            let itemIndex = -1;
            for (let i = 0; i< content.length; i++){
                if(id === content[i].id){
                    itemIndex = i;
                    break;
                }
            }
            if(itemIndex === -1){
                alert("Not a valid ID. Please try again");
                return
            }
            for (let i =0; i < content[itemIndex].data.length; i++){
                dateTime.push(content[itemIndex].data[i].date_time_pulled);
                likeOverTime.push(content[itemIndex].data[i].data.like_count);
                replyOverTime.push(content[itemIndex].data[i].data.reply_count);
                retweetOverTime.push(content[itemIndex].data[i].data.retweet_count);
            }

            drawTrackingCharts(id,chartID,dateTime,likeOverTime,replyOverTime,retweetOverTime);
            //console.log(index);
            console.log(dateTime);
            console.log(likeOverTime);
            console.log(replyOverTime);
            console.log(retweetOverTime);
        }



        function insertChartTable(dataType,tableID){
            let table = document.getElementById(tableID);
            let row = table.insertRow(0);
            let nameCell = row.insertCell(0);
            let frequencyCell = row.insertCell(1);
            nameCell.innerHTML = dataType.charAt(0).toUpperCase() + dataType.slice(1);
            frequencyCell.innerHTML = "Frequency";

            let data = ${data}
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

            let data = ${data}
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
                '<a class="page-link" onclick="dynamicTableInsert('+ pre +')" tabindex="-1">Previous</a>'+
                '</li>'+
                '</ul>'+
                '</nav>';
            document.querySelector("#tweet-pagination").innerHTML = pagination;

            let data = ${data}
            let dataSize = data.sorted_tweet.length;
            let pageNum = (dataSize / 10) + 1;

            var ul = document.querySelector("#page-list");
            for(let i = 0; i < pageNum-1; i++){
                let li = document.createElement("li");
                li.innerHTML = '<a class="page-link" onclick="dynamicTableInsert('+i+')">'+i+'</a>';
                ul.appendChild(li);
            }
            let next = currentPage +1;
            let li = document.createElement("li");
            li.innerHTML = '<li class="page-item">'+
                '<a class="page-link" onclick="dynamicTableInsert('+ next +')" >Next </a>'+
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

        function dynamicTableInsert(index){
            try{
                let data = ${data}
                let dataSize = data.sorted_tweet.length;
                let pageNum = (dataSize / 10) + 1;

                if(index < 0){
                    index = 0;
                }
                if(index > pageNum){
                    index = pageNum;
                }
                currentPage = index;

                let start = index*10;
                let end = index*10 + 10;
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

        function getTrackId(trackID,chartID){
            let trackId = document.getElementById(trackID).value;
            prepareTrackingJson(trackId,chartID);
            console.log(trackId);
        }
        var chartArrayNumber = [];

        function findMissingNumber(array){
            n = 1;
            let element = 0;
            let diff = 0;
            for(let i=0; i<array.length; ++i) {
                const difference = array[i] - element - 1;
                const sum = diff + difference;
                if(sum>=n) {
                    break;
                }
                diff = sum;
                element = array[i];
            }
            return element + n - diff;
        }

        function addTrackChart(){
            let nextIndex = findMissingNumber(chartArrayNumber);
            let trackID = "trackID" + nextIndex;
            let trackChartID = "trackChart" + nextIndex;
            let containerIndex = nextIndex +5;
            let chartContainer = "chart-container" + containerIndex;
            let removeButtonArgument = "container-"+ trackChartID;
            let canvas = document.createElement('canvas');
            canvas.setAttribute('id', trackChartID);


            let canvasContainer = document.createElement('div');
            canvasContainer.setAttribute('id', chartContainer);
            canvasContainer.setAttribute('class', "chart special");
            canvasContainer.setAttribute('style', "position: relative;");
            canvasContainer.appendChild(canvas);

            let inputTrackContainer = document.createElement('div')
            let inputId = document.createElement('input');
            inputId.setAttribute('type',"text");
            inputId.setAttribute('id', trackID);
            inputId.setAttribute('placeholder', "Type Id to track");

            let buttonTrack = document.createElement('button');
            buttonTrack.setAttribute('onclick', "getTrackId('"+trackID+"','"+ trackChartID+"')");
            buttonTrack.textContent = "Track";
            let buttonRemove = document.createElement('button');
            buttonRemove.setAttribute('onclick', "removeChart('"+removeButtonArgument+"')");
            buttonRemove.textContent = "Remove";
            inputTrackContainer.appendChild(inputId);
            inputTrackContainer.appendChild(buttonTrack);
            inputTrackContainer.appendChild(buttonRemove);

            let wholeContainer = document.createElement('div');
            wholeContainer.setAttribute('class', "col-sm-12 col-xl-6 canvas-container");
            wholeContainer.setAttribute('id', "container-"+ trackChartID);
            wholeContainer.appendChild(inputTrackContainer);
            wholeContainer.appendChild(canvasContainer);


            chartArrayNumber.push(nextIndex);
            document.getElementById("dynamic-row").appendChild(wholeContainer);
        }
        function removeChart(divID){
            let id = divID.substr(20,divID.length);
            let index = parseInt(id);
            console.log("index: " + id);
            let makeSure = index -1;
            chartArrayNumber.splice(makeSure,1);
            chartArrayNumber.sort();
            console.log(chartArrayNumber);
            document.getElementById(divID).remove();

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
            console.log([{"data":[{"date_time_pulled":"2022-05-18T09:01:59.378","data":{"like_count":73525,"reply_count":24567,"quote_count":2632,"retweet_count":10911}},{"date_time_pulled":"2022-05-18T09:03:24.092","data":{"like_count":73577,"reply_count":24574,"quote_count":2632,"retweet_count":10918}},{"date_time_pulled":"2022-05-18T09:03:31.925","data":{"like_count":73585,"reply_count":24576,"quote_count":2632,"retweet_count":10918}},{"date_time_pulled":"2022-05-18T09:03:36.021","data":{"like_count":73588,"reply_count":24576,"quote_count":2632,"retweet_count":10919}},{"date_time_pulled":"2022-05-18T09:12:27.806","data":{"like_count":73899,"reply_count":24651,"quote_count":2636,"retweet_count":10969}},{"date_time_pulled":"2022-05-18T09:19:26.661","data":{"like_count":74181,"reply_count":24713,"quote_count":2641,"retweet_count":11005}},{"date_time_pulled":"2022-05-18T10:47:18.696","data":{"like_count":77332,"reply_count":25378,"quote_count":2726,"retweet_count":11351}},{"date_time_pulled":"2022-05-18T10:49:12.961","data":{"like_count":77412,"reply_count":25410,"quote_count":2727,"retweet_count":11360}},{"date_time_pulled":"2022-05-18T10:53:16.047","data":{"like_count":77559,"reply_count":25442,"quote_count":2730,"retweet_count":11379}},{"date_time_pulled":"2022-05-18T10:55:11.390","data":{"like_count":77633,"reply_count":25462,"quote_count":2732,"retweet_count":11392}},{"date_time_pulled":"2022-05-18T10:55:20.074","data":{"like_count":77636,"reply_count":25463,"quote_count":2732,"retweet_count":11392}},{"date_time_pulled":"2022-05-18T10:58:14.125","data":{"like_count":77722,"reply_count":25486,"quote_count":2734,"retweet_count":11403}},{"date_time_pulled":"2022-05-18T11:00:45.018","data":{"like_count":77807,"reply_count":25482,"quote_count":2736,"retweet_count":11412}},{"date_time_pulled":"2022-05-18T11:03:57.606","data":{"like_count":77918,"reply_count":25527,"quote_count":2738,"retweet_count":11426}},{"date_time_pulled":"2022-05-18T11:06:19.331","data":{"like_count":77989,"reply_count":25525,"quote_count":2740,"retweet_count":11436}},{"date_time_pulled":"2022-05-18T11:07:45.614","data":{"like_count":78030,"reply_count":25535,"quote_count":2740,"retweet_count":11440}},{"date_time_pulled":"2022-05-18T11:09:08.343","data":{"like_count":78077,"reply_count":25559,"quote_count":2741,"retweet_count":11444}},{"date_time_pulled":"2022-05-18T11:10:29.765","data":{"like_count":78129,"reply_count":25571,"quote_count":2742,"retweet_count":11449}},{"date_time_pulled":"2022-05-18T11:14:34.285","data":{"like_count":78253,"reply_count":25569,"quote_count":2748,"retweet_count":11464}},{"date_time_pulled":"2022-05-18T11:19:51.518","data":{"like_count":78415,"reply_count":25607,"quote_count":2750,"retweet_count":11488}},{"date_time_pulled":"2022-05-18T11:20:15.758","data":{"like_count":78421,"reply_count":25631,"quote_count":2751,"retweet_count":11488}},{"date_time_pulled":"2022-05-18T11:22:51.398","data":{"like_count":78469,"reply_count":25636,"quote_count":2750,"retweet_count":11503}},{"date_time_pulled":"2022-05-18T11:24:26.534","data":{"like_count":78541,"reply_count":25670,"quote_count":2752,"retweet_count":11503}},{"date_time_pulled":"2022-05-18T11:26:48.299","data":{"like_count":78618,"reply_count":25680,"quote_count":2754,"retweet_count":11508}},{"date_time_pulled":"2022-05-18T11:32:56.907","data":{"like_count":78762,"reply_count":25714,"quote_count":2759,"retweet_count":11539}},{"date_time_pulled":"2022-05-18T11:34:22.310","data":{"like_count":78812,"reply_count":25728,"quote_count":2761,"retweet_count":11544}},{"date_time_pulled":"2022-05-18T11:36:06.449","data":{"like_count":78894,"reply_count":25750,"quote_count":2764,"retweet_count":11547}},{"date_time_pulled":"2022-05-18T11:37:22.053","data":{"like_count":78935,"reply_count":25759,"quote_count":2764,"retweet_count":11554}},{"date_time_pulled":"2022-05-18T11:40:10.828","data":{"like_count":79028,"reply_count":25777,"quote_count":2765,"retweet_count":11567}},{"date_time_pulled":"2022-05-18T12:03:05.421","data":{"like_count":79666,"reply_count":25905,"quote_count":2779,"retweet_count":11666}},{"date_time_pulled":"2022-05-18T12:05:18.875","data":{"like_count":79729,"reply_count":25924,"quote_count":2787,"retweet_count":11672}},{"date_time_pulled":"2022-05-18T12:14:35.220","data":{"like_count":80007,"reply_count":25986,"quote_count":2791,"retweet_count":11704}},{"date_time_pulled":"2022-05-18T12:16:19.978","data":{"like_count":80053,"reply_count":25992,"quote_count":2791,"retweet_count":11708}},{"date_time_pulled":"2022-05-18T12:19:41.233","data":{"like_count":80139,"reply_count":26013,"quote_count":2797,"retweet_count":11721}},{"date_time_pulled":"2022-05-18T12:22:31.478","data":{"like_count":80217,"reply_count":26025,"quote_count":2798,"retweet_count":11734}},{"date_time_pulled":"2022-05-18T12:25:15.060","data":{"like_count":80294,"reply_count":26035,"quote_count":2796,"retweet_count":11745}},{"date_time_pulled":"2022-05-18T12:32:18.893","data":{"like_count":80482,"reply_count":26068,"quote_count":2797,"retweet_count":11780}},{"date_time_pulled":"2022-05-18T12:34:24.863","data":{"like_count":80535,"reply_count":26082,"quote_count":2797,"retweet_count":11786}},{"date_time_pulled":"2022-05-18T12:48:51.280","data":{"like_count":81035,"reply_count":26170,"quote_count":2813,"retweet_count":11849}},{"date_time_pulled":"2022-05-18T12:51:54.027","data":{"like_count":81112,"reply_count":26192,"quote_count":2814,"retweet_count":11855}},{"date_time_pulled":"2022-05-18T12:55:48.287","data":{"like_count":81225,"reply_count":26203,"quote_count":2809,"retweet_count":11865}},{"date_time_pulled":"2022-05-18T12:59:40.986","data":{"like_count":81324,"reply_count":26234,"quote_count":2818,"retweet_count":11871}},{"date_time_pulled":"2022-05-18T13:03:03.753","data":{"like_count":81433,"reply_count":26246,"quote_count":2816,"retweet_count":11882}},{"date_time_pulled":"2022-05-18T13:04:21.276","data":{"like_count":81475,"reply_count":26253,"quote_count":2822,"retweet_count":11888}},{"date_time_pulled":"2022-05-18T13:06:07.972","data":{"like_count":81534,"reply_count":26258,"quote_count":2817,"retweet_count":11890}},{"date_time_pulled":"2022-05-18T13:08:32.867","data":{"like_count":81616,"reply_count":26278,"quote_count":2825,"retweet_count":11898}},{"date_time_pulled":"2022-05-18T13:10:20.578","data":{"like_count":81661,"reply_count":26290,"quote_count":2825,"retweet_count":11898}},{"date_time_pulled":"2022-05-18T13:11:56.918","data":{"like_count":81714,"reply_count":26307,"quote_count":2827,"retweet_count":11901}},{"date_time_pulled":"2022-05-18T13:13:44.448","data":{"like_count":81771,"reply_count":26317,"quote_count":2829,"retweet_count":11906}},{"date_time_pulled":"2022-05-18T14:27:47.994","data":{"like_count":83888,"reply_count":26707,"quote_count":2879,"retweet_count":12124}},{"date_time_pulled":"2022-05-18T20:07:21.746","data":{"like_count":90917,"reply_count":27961,"quote_count":3015,"retweet_count":12987}},{"date_time_pulled":"2022-05-18T20:09:13.354","data":{"like_count":90950,"reply_count":27968,"quote_count":3016,"retweet_count":12990}}],"id":"1526598807722549248"},{"data":[{"date_time_pulled":"2022-05-18T09:01:59.378","data":{"like_count":84565,"reply_count":6762,"quote_count":739,"retweet_count":6640}},{"date_time_pulled":"2022-05-18T09:03:24.092","data":{"like_count":84646,"reply_count":6761,"quote_count":740,"retweet_count":6645}},{"date_time_pulled":"2022-05-18T09:03:31.925","data":{"like_count":84662,"reply_count":6761,"quote_count":740,"retweet_count":6645}},{"date_time_pulled":"2022-05-18T09:03:36.021","data":{"like_count":84672,"reply_count":6761,"quote_count":740,"retweet_count":6646}},{"date_time_pulled":"2022-05-18T09:12:27.806","data":{"like_count":85316,"reply_count":6779,"quote_count":741,"retweet_count":6695}},{"date_time_pulled":"2022-05-18T09:19:26.661","data":{"like_count":85785,"reply_count":6800,"quote_count":743,"retweet_count":6727}},{"date_time_pulled":"2022-05-18T10:47:18.696","data":{"like_count":90850,"reply_count":6997,"quote_count":757,"retweet_count":7010}},{"date_time_pulled":"2022-05-18T10:49:12.961","data":{"like_count":91001,"reply_count":7003,"quote_count":761,"retweet_count":7019}},{"date_time_pulled":"2022-05-18T10:53:16.047","data":{"like_count":91234,"reply_count":7018,"quote_count":762,"retweet_count":7030}},{"date_time_pulled":"2022-05-18T10:55:11.390","data":{"like_count":91344,"reply_count":7020,"quote_count":762,"retweet_count":7038}},{"date_time_pulled":"2022-05-18T10:55:20.074","data":{"like_count":91352,"reply_count":7019,"quote_count":762,"retweet_count":7038}},{"date_time_pulled":"2022-05-18T10:58:14.125","data":{"like_count":91490,"reply_count":7025,"quote_count":762,"retweet_count":7047}},{"date_time_pulled":"2022-05-18T11:00:45.018","data":{"like_count":91618,"reply_count":7031,"quote_count":763,"retweet_count":7055}},{"date_time_pulled":"2022-05-18T11:03:57.606","data":{"like_count":91802,"reply_count":7038,"quote_count":764,"retweet_count":7060}},{"date_time_pulled":"2022-05-18T11:06:19.331","data":{"like_count":91897,"reply_count":7047,"quote_count":764,"retweet_count":7066}},{"date_time_pulled":"2022-05-18T11:07:45.614","data":{"like_count":91989,"reply_count":7050,"quote_count":762,"retweet_count":7071}},{"date_time_pulled":"2022-05-18T11:09:08.343","data":{"like_count":92083,"reply_count":7053,"quote_count":764,"retweet_count":7076}},{"date_time_pulled":"2022-05-18T11:10:29.765","data":{"like_count":92138,"reply_count":7055,"quote_count":764,"retweet_count":7077}},{"date_time_pulled":"2022-05-18T11:14:34.285","data":{"like_count":92315,"reply_count":7059,"quote_count":763,"retweet_count":7088}},{"date_time_pulled":"2022-05-18T11:19:51.518","data":{"like_count":92594,"reply_count":7074,"quote_count":766,"retweet_count":7103}},{"date_time_pulled":"2022-05-18T11:20:15.758","data":{"like_count":92638,"reply_count":7076,"quote_count":768,"retweet_count":7104}},{"date_time_pulled":"2022-05-18T11:22:51.398","data":{"like_count":92732,"reply_count":7080,"quote_count":766,"retweet_count":7109}},{"date_time_pulled":"2022-05-18T11:24:26.534","data":{"like_count":92838,"reply_count":7079,"quote_count":768,"retweet_count":7116}},{"date_time_pulled":"2022-05-18T11:26:48.299","data":{"like_count":92938,"reply_count":7084,"quote_count":768,"retweet_count":7118}},{"date_time_pulled":"2022-05-18T11:32:56.907","data":{"like_count":93214,"reply_count":7094,"quote_count":767,"retweet_count":7136}},{"date_time_pulled":"2022-05-18T11:34:22.310","data":{"like_count":93302,"reply_count":7096,"quote_count":767,"retweet_count":7145}},{"date_time_pulled":"2022-05-18T11:36:06.449","data":{"like_count":93429,"reply_count":7101,"quote_count":769,"retweet_count":7154}},{"date_time_pulled":"2022-05-18T11:37:22.053","data":{"like_count":93494,"reply_count":7104,"quote_count":770,"retweet_count":7159}},{"date_time_pulled":"2022-05-18T11:40:10.828","data":{"like_count":93665,"reply_count":7107,"quote_count":772,"retweet_count":7173}},{"date_time_pulled":"2022-05-18T12:03:05.421","data":{"like_count":94766,"reply_count":7161,"quote_count":778,"retweet_count":7251}},{"date_time_pulled":"2022-05-18T12:05:18.875","data":{"like_count":94900,"reply_count":7166,"quote_count":781,"retweet_count":7259}},{"date_time_pulled":"2022-05-18T12:14:35.220","data":{"like_count":95300,"reply_count":7197,"quote_count":781,"retweet_count":7288}},{"date_time_pulled":"2022-05-18T12:16:19.978","data":{"like_count":95387,"reply_count":7197,"quote_count":781,"retweet_count":7293}},{"date_time_pulled":"2022-05-18T12:19:41.233","data":{"like_count":95535,"reply_count":7201,"quote_count":785,"retweet_count":7299}},{"date_time_pulled":"2022-05-18T12:22:31.478","data":{"like_count":95662,"reply_count":7213,"quote_count":785,"retweet_count":7307}},{"date_time_pulled":"2022-05-18T12:25:15.060","data":{"like_count":95776,"reply_count":7219,"quote_count":783,"retweet_count":7317}},{"date_time_pulled":"2022-05-18T12:32:18.893","data":{"like_count":96083,"reply_count":7232,"quote_count":784,"retweet_count":7329}},{"date_time_pulled":"2022-05-18T12:34:24.863","data":{"like_count":96165,"reply_count":7236,"quote_count":784,"retweet_count":7333}},{"date_time_pulled":"2022-05-18T12:48:51.280","data":{"like_count":96788,"reply_count":7256,"quote_count":789,"retweet_count":7363}},{"date_time_pulled":"2022-05-18T12:51:54.027","data":{"like_count":96924,"reply_count":7260,"quote_count":789,"retweet_count":7364}},{"date_time_pulled":"2022-05-18T12:55:48.287","data":{"like_count":97090,"reply_count":7265,"quote_count":788,"retweet_count":7371}},{"date_time_pulled":"2022-05-18T12:59:40.986","data":{"like_count":97198,"reply_count":7273,"quote_count":793,"retweet_count":7380}},{"date_time_pulled":"2022-05-18T13:03:03.753","data":{"like_count":97342,"reply_count":7280,"quote_count":791,"retweet_count":7385}},{"date_time_pulled":"2022-05-18T13:04:21.276","data":{"like_count":97374,"reply_count":7280,"quote_count":794,"retweet_count":7391}},{"date_time_pulled":"2022-05-18T13:06:07.972","data":{"like_count":97457,"reply_count":7281,"quote_count":792,"retweet_count":7393}},{"date_time_pulled":"2022-05-18T13:08:32.867","data":{"like_count":97544,"reply_count":7290,"quote_count":794,"retweet_count":7400}},{"date_time_pulled":"2022-05-18T13:10:20.578","data":{"like_count":97611,"reply_count":7295,"quote_count":795,"retweet_count":7404}},{"date_time_pulled":"2022-05-18T13:11:56.918","data":{"like_count":97667,"reply_count":7296,"quote_count":795,"retweet_count":7406}},{"date_time_pulled":"2022-05-18T13:13:44.448","data":{"like_count":97721,"reply_count":7298,"quote_count":795,"retweet_count":7408}},{"date_time_pulled":"2022-05-18T14:27:47.994","data":{"like_count":100104,"reply_count":7405,"quote_count":805,"retweet_count":7537}},{"date_time_pulled":"2022-05-18T20:07:21.746","data":{"like_count":108802,"reply_count":7726,"quote_count":834,"retweet_count":7932}},{"date_time_pulled":"2022-05-18T20:09:13.354","data":{"like_count":108849,"reply_count":7728,"quote_count":834,"retweet_count":7937}}],"id":"1526636363906437120"}]);
        })

    </script>

    <style>
        .special{
            border: black solid 1px;
            border-radius: 10px;
            background-color: #a6b7c5;
        }
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
        #trackChart{

        }
        #chart-container5{

        }
        #main-trackChart-container{
            width: fit-content;
            margin: auto;
            margin-top: 10px;
        }
        .decorate-container{
            padding: 10px;
            border: black 1px solid;
            border-radius: 10px;
            background-color: #a6b7c5;
        }
        main{
            background-color: #F0E5CF;
            height: 100%;
        }
        .decorate-tweet-container{
            width: fit-content;
            margin:auto;
            margin-top: 10px;
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
                    <div class="decorate-container">
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
                </div>
                <div class="col-sm-6 col-xl-3 canvas-container">
                    <div class="decorate-container">
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
                </div>
                <div class="col-sm-6 col-xl-3 canvas-container">
                    <div class="decorate-container">
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
                </div>
                <div class="col-sm-6 col-xl-3 canvas-container">
                    <div class="decorate-container">
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
                <div style="margin-bottom: 10px;" id="main-trackChart-container" class="col-sm-12 col-xl-8 canvas-container decorate-container">
                    <div><input type="text" id="trackID" placeholder="Type Id to track">
                        <button onclick="getTrackId('trackID', 'trackChart')">Track</button>

                    </div>
                    <div id = "chart-container5" class="chart" style="position: relative;">
                        <canvas id="trackChart"></canvas>
                    </div>
                </div>
            </div>
            <div id="dynamic-row" class="row">

            </div>
        </div>
    </section>
    <div class="decorate-tweet-container">
        <div id="button ">
            <div><button onclick="addTrackChart();">Add Track Chart</button></div>
        </div>
        <div id="tweets">
        </div>
        <div id="tweet-pagination">
        </div>
    </div>
</main>
</body>
</html>