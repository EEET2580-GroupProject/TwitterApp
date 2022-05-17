<div id="advanced-search-tab" style="display: none">
    <div id="main-items">
        <form id="setrules-form" method="get" action="/twitter/setrules">
            <div class="main-ele">
                <div id="box-around-input">
                    <i id="icon" class='fa-solid fa-magnifying-glass'></i>
                    <input id="term-field" type="text" name="q-term" placeholder="Keywords">
                </div>
            </div>
            <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-row">
                                <div class="form-label">
                                    <label for="exclude">Exclude these words: </label>
                                </div>
                                <div class="form-field">
                                    <input class="inputs" type="text" id="exclude" name="q-exclude">
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-label">
                                    <label for="any-word">Any of these words:</label>
                                </div>
                                <div class="form-field">
                                    <input class="inputs" type="text" id="any-word" name="q-or">
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-label">
                                    <label for="exact-word">Exact these words: </label>
                                </div>
                                <div class="form-field">
                                    <input class="inputs" type="text" id="exact-word" name="q-exact">
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-label">
                                    <label for="hashtag">Hastags: </label>
                                </div>
                                <div class="form-field">
                                    <input class="inputs" type="text" id="hashtag" name="q-hashtag">
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-label">
                                    <label for="usertag">Usertags: </label>
                                </div>
                                <div class="form-field">
                                    <input class="inputs" type="text" id="usertag" name="q-usertag">
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-label">
                                    <label for="from-user">From user: </label>
                                </div>
                                <div class="form-field">
                                    <input class="inputs" type="text" id="from-user" name="q-fromuser">
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-label">
                                    <label for="to-user">To user: </label>
                                </div>
                                <div class="form-field">
                                    <input class="inputs" type="text" id="to-user" name="q-touser">
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-label">
                                    <label for="retweet-of">Retweet of user: </label>
                                </div>
                                <div class="form-field">
                                    <input class="inputs" type="text" id="retweet-of" name="q-retweetof">
                                </div>
                            </div>


                            <input type="checkbox" id="is-retweet" name="q-isretweet" value="/on/">
                            <label for="is-retweet"> Is retweet</label>
                            <input type="checkbox" id="is-reply" name="q-isreply" value="/on/">
                            <label for="is-reply"> Is reply</label>
                            <input type="checkbox" id="is-quote" name="q-isquote" value="/on/">
                            <label for="is-quote"> Is quote</label>
                            <input type="checkbox" id="is-verified" name="q-isverified" value="/on/">
                            <label for="is-verified"> From verified account</label>
                            <input type="checkbox" id="has-hashtag" name="q-hashashtag" value="/on/">
                            <label for="has-hashtag"> Has atleast one hashtag</label>
                            <input type="checkbox" id="has-links" name="q-haslink" value="/on/">
                            <label for="has-links"> Has links</label>
                            <input type="checkbox" id="has-mentions" name="q-mentions" value="/on/">
                            <label for="has-mentions"> Has mentions</label>
                            <input type="checkbox" id="has-media" name="q-media" value="/on/">
                            <label for="has-media"> Has media</label>
                            <input type="checkbox" id="has-images" name="q-hasimages" value="/on/">
                            <label for="has-images"> Has images</label>
                            <input type="checkbox" id="has-videos" name="q-hasvideos" value="/on/">
                            <label for="has-videos"> Has videos</label>

                            <select id="language" class="inputs" name="q-language">
                                <option value=af>Afrikaans</option>
                                <option value=sq>Albanian</option>
                                <option value=am>Amharic</option>
                                <option value=ar>Arabic</option>
                                <option value=hy>Armenian</option>
                                <option value=az>Azerbaijani</option>
                                <option value=eu>Basque</option>
                                <option value=be>Belarusian</option>
                                <option value=bn>Bengali</option>
                                <option value=bs>Bosnian</option>
                                <option value=bg>Bulgarian</option>
                                <option value=ca>Catalan</option>
                                <option value=ceb>Cebuano</option>
                                <option value=ny>Chichewa</option>
                                <option value=zh-CN>Chinese</option>
                                <option value=co>Corsican</option>
                                <option value=hr>Croatian</option>
                                <option value=cs>Czech</option>
                                <option value=da>Danish</option>
                                <option value=nl>Dutch</option>
                                <option value=en selected>English</option>
                                <option value=eo>Esperanto</option>
                                <option value=et>Estonian</option>
                                <option value=tl>Filipino</option>
                                <option value=fi>Finnish</option>
                                <option value=fr>French</option>
                                <option value=fy>Frisian</option>
                                <option value=gl>Galician</option>
                                <option value=ka>Georgian</option>
                                <option value=de>German</option>
                                <option value=el>Greek</option>
                                <option value=gu>Gujarati</option>
                                <option value=ht>Haitian Creole</option>
                                <option value=ha>Hausa</option>
                                <option value=haw>Hawaiian</option>
                                <option value=iw>Hebrew</option>
                                <option value=hi>Hindi</option>
                                <option value=hmn>Hmong</option>
                                <option value=hu>Hungarian</option>
                                <option value=is>Icelandic</option>
                                <option value=ig>Igbo</option>
                                <option value=id>Indonesian</option>
                                <option value=ga>Irish</option>
                                <option value=it>Italian</option>
                                <option value=ja>Japanese</option>
                                <option value=jw>Javanese</option>
                                <option value=kn>Kannada</option>
                                <option value=kk>Kazakh</option>
                                <option value=km>Khmer</option>
                                <option value=ko>Korean</option>
                                <option value=ku>Kurdish (Kurmanji)</option>
                                <option value=ky>Kyrgyz</option>
                                <option value=lo>Lao</option>
                                <option value=la>Latin</option>
                                <option value=lv>Latvian</option>
                                <option value=lt>Lithuanian</option>
                                <option value=lb>Luxembourgish</option>
                                <option value=mk>Macedonian</option>
                                <option value=mg>Malagasy</option>
                                <option value=ms>Malay</option>
                                <option value=ml>Malayalam</option>
                                <option value=mt>Maltese</option>
                                <option value=mi>Maori</option>
                                <option value=mr>Marathi</option>
                                <option value=mn>Mongolian</option>
                                <option value=my>Myanmar (Burmese)</option>
                                <option value=ne>Nepali</option>
                                <option value=no>Norwegian</option>
                                <option value=ps>Pashto</option>
                                <option value=fa>Persian</option>
                                <option value=pl>Polish</option>
                                <option value=pt>Portuguese</option>
                                <option value=pa>Punjabi</option>
                                <option value=ro>Romanian</option>
                                <option value=ru>Russian</option>
                                <option value=sm>Samoan</option>
                                <option value=gd>Scots Gaelic</option>
                                <option value=sr>Serbian</option>
                                <option value=st>Sesotho</option>
                                <option value=sn>Shona</option>
                                <option value=sd>Sindhi</option>
                                <option value=si>Sinhala</option>
                                <option value=sk>Slovak</option>
                                <option value=sl>Slovenian</option>
                                <option value=so>Somali</option>
                                <option value=es>Spanish</option>
                                <option value=su>Sundanese</option>
                                <option value=sw>Swahili</option>
                                <option value=sv>Swedish</option>
                                <option value=tg>Tajik</option>
                                <option value=ta>Tamil</option>
                                <option value=te>Telugu</option>
                                <option value=th>Thai</option>
                                <option value=tr>Turkish</option>
                                <option value=uk>Ukrainian</option>
                                <option value=ur>Urdu</option>
                                <option value=uz>Uzbek</option>
                                <option value=vi>Vietnamese</option>
                                <option value=cy>Welsh</option>
                                <option value=xh>Xhosa</option>
                                <option value=yi>Yiddish</option>
                                <option value=yo>Yoruba</option>
                                <option value=zu>Zulu</option>
                            </select>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
            <input class="inputs" id="tag" name="q-tag" type="text" placeholder="Tag"/>
        </form>
        <div>
            <div id="button-box">
                <form id="connect-form" method="get" action="/twitter/connectStream">
                    <!-- Modal -->
                    <div class="modal fade" id="modal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="modal2Label">Specify maximum tweets</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <label for="max-tweet">Maximum is 40 tweets:</label>
                                    <input id="max-tweet" style="width: 200px" type="number" min="0" max="40" name="q-max" placeholder="Max Tweet"></input>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    <button type="submit" form="connect-form" class="btn btn-primary">Save changes</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
                <button class="button-ele" data-toggle="modal" data-target="#modal2" >Connect to Stream</button>
                <input class="button-ele" form="setrules-form" type="submit" value="Import rules">
                <button id="advanced-search-button" class="button-ele"  data-toggle="modal" data-target="#exampleModal">Advanced Search</button>
            </div>
        </div>
    </div>
    <div id="nortification">
        <span id="query-label">${query}</span>
        <span>${report}</span>
    </div>
</div>