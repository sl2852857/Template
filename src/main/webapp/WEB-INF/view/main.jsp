<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layouts/head.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- settings changer -->
        <div class="skins-nav">
            <a href="#" class="skin first_nav selected">
                <span class="icon"></span><span class="text">Default skin</span>
            </a>
            <a href="#" class="skin second_nav" data-file="${cssPath}/skins/dark.css">
                <span class="icon"></span><span class="text">Dark skin</span>
            </a>
        </div>

        <div class="container-fluid">

            <!-- upper main stats -->
            <div id="main-stats">
                <div class="row-fluid stats-row">
                    <div class="span3 stat">
                        <div class="data">
                            <span class="number">2457</span>
                            visits
                        </div>
                        <span class="date">Today</span>
                    </div>
                    <div class="span3 stat">
                        <div class="data">
                            <span class="number">3240</span>
                            users
                        </div>
                        <span class="date">February 2014</span>
                    </div>
                    <div class="span3 stat">
                        <div class="data">
                            <span class="number">322</span>
                            orders
                        </div>
                        <span class="date">This week</span>
                    </div>
                    <div class="span3 stat last">
                        <div class="data">
                            <span class="number">$2,340</span>
                            sales
                        </div>
                        <span class="date">last 30 days</span>
                    </div>
                </div>
            </div>
            <!-- end upper main stats -->

            <div id="pad-wrapper">

                <!-- statistics chart built with jQuery Flot -->
                <div class="row-fluid chart">
                    <h4>
                        Statistics
                         <div class="btn-group pull-right">
                            <button class="glow left">DAY</button>
                            <button class="glow middle active">MONTH</button>
                            <button class="glow right">YEAR</button>
                        </div>
                    </h4>
                    <div class="span12">
                        <div id="statsChart"></div>
                    </div>
                </div>
                <!-- end statistics chart -->

                <!-- UI Elements section -->
                <div class="row-fluid section ui-elements">
                    <h4>UI Elements</h4>
                    <div class="span5 knobs">
                        <div class="knob-wrapper">
                            <input type="text" value="50" class="knob" data-thickness=".3" data-inputcolor="#333" data-fgcolor="#30a1ec" data-bgcolor="#d4ecfd" data-width="150" />
                            <div class="info">
                                <div class="param">
                                    <span class="line blue"></span>
                                    Active users
                                </div>
                            </div>
                        </div>
                        <div class="knob-wrapper">
                            <input type="text" value="75" class="knob second" data-thickness=".3" data-inputcolor="#333" data-fgcolor="#3d88ba" data-bgcolor="#d4ecfd" data-width="150" />
                            <div class="info">
                                <div class="param">
                                    <span class="line blue"></span>
                                    % disk space usage
                                </div>
                            </div>
                        </div>                        
                    </div>
                    <div class="span6 showcase">
                        <div class="ui-sliders">
                            <div class="slider slider-sample1 vertical-handler"></div>
                            <div class="slider slider-sample2"></div>
                            <div class="slider slider-sample3"></div>
                        </div>
                        <div class="ui-group">
                            <a class="btn-flat inverse">Large Button</a>
                            <a class="btn-flat gray">Large Button</a>
                            <a class="btn-flat default">Large Button</a>
                            <a class="btn-flat primary">Large Button</a>
                        </div>                        

                        <div class="ui-group">
                            <a class="btn-flat icon">
                                <i class="tool"></i> Icon button
                            </a>
                            <a class="btn-glow small inverse">
                                <i class="shuffle"></i>
                            </a>
                            <a class="btn-glow small primary">
                                <i class="setting"></i>
                            </a>
                            <a class="btn-glow small default">
                                <i class="attach"></i>
                            </a>
                            <div class="ui-select">
                                <select>
                                    <option selected="" />Dropdown
                                    <option />Custom selects
                                    <option />Pure css styles
                                </select>
                            </div>

                            <div class="btn-group">
                                <button class="glow left">LEFT</button>
                                <button class="glow right">RIGHT</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end UI elements section -->

                <!-- table sample -->
                <!-- the script for the toggle all checkboxes from header is located in js/theme.js -->
                <div class="table-products section">
                    <div class="row-fluid head">
                        <div class="span12">
                            <h4>Products <small>Table sample</small></h4>
                        </div>
                    </div>

                    <div class="row-fluid filter-block">
                        <div class="pull-right">
                            <div class="ui-select">
                                <select>
                                  <option />Filter users
                                  <option />Signed last 30 days
                                  <option />Active users
                                </select>
                            </div>
                            <input type="text" class="search" />
                            <a class="btn-flat new-product">+ Add product</a>
                        </div>
                    </div>

                    <div class="row-fluid">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th class="span3">
                                        <input type="checkbox" />
                                        Product
                                    </th>
                                    <th class="span3">
                                        <span class="line"></span>Description
                                    </th>
                                    <th class="span3">
                                        <span class="line"></span>Status
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- row -->
                                <tr class="first">
                                    <td>
                                        <input type="checkbox" />
                                        <div class="img">
                                            <img src="${imgPath}/table-img.png" />
                                        </div>
                                        <a href="#">There are many variations </a>
                                    </td>
                                    <td class="description">
                                        if you are going to use a passage of Lorem Ipsum.
                                    </td>
                                    <td>
                                        <span class="label label-success">Active</span>
                                        <ul class="actions">
                                            <li><i class="table-edit"></i></li>
                                            <li><i class="table-settings"></i></li>
                                            <li class="last"><i class="table-delete"></i></li>
                                        </ul>
                                    </td>
                                </tr>
                                <!-- row -->
                                <tr>
                                    <td>
                                        <input type="checkbox" />
                                        <div class="img">
                                            <img src="${imgPath}/table-img.png" />
                                        </div>
                                        <a href="#">Internet tend</a>
                                    </td>
                                    <td class="description">
                                        There are many variations of passages.
                                    </td>
                                    <td>
                                        <ul class="actions">
                                            <li><i class="table-edit"></i></li>
                                            <li><i class="table-settings"></i></li>
                                            <li class="last"><i class="table-delete"></i></li>
                                        </ul>
                                    </td>
                                </tr>
                                <!-- row -->
                                <tr>
                                    <td>
                                        <input type="checkbox" />
                                        <div class="img">
                                            <img src="${imgPath}/table-img.png" />
                                        </div>
                                        <a href="#">Many desktop publishing </a>
                                    </td>
                                    <td class="description">
                                        if you are going to use a passage of Lorem Ipsum.
                                    </td>
                                    <td>
                                        <ul class="actions">
                                            <li><i class="table-edit"></i></li>
                                            <li><i class="table-settings"></i></li>
                                            <li class="last"><i class="table-delete"></i></li>
                                        </ul>
                                    </td>
                                </tr>
                                <!-- row -->
                                <tr>
                                    <td>
                                        <input type="checkbox" />
                                        <div class="img">
                                            <img src="${imgPath}/table-img.png" />
                                        </div>
                                        <a href="#">Generate Lorem </a>
                                    </td>
                                    <td class="description">
                                        There are many variations of passages.
                                    </td>
                                    <td>
                                        <span class="label label-info">Standby</span>
                                        <ul class="actions">
                                            <li><i class="table-edit"></i></li>
                                            <li><i class="table-settings"></i></li>
                                            <li class="last"><i class="table-delete"></i></li>
                                        </ul>
                                    </td>
                                </tr>
                                <!-- row -->
                                <tr>
                                    <td>
                                        <input type="checkbox" />
                                        <div class="img">
                                            <img src="${imgPath}/table-img.png" />
                                        </div>
                                        <a href="#">Internet tend</a>
                                    </td>
                                    <td class="description">
                                        There are many variations of passages.
                                    </td>
                                    <td>                                        
                                        <ul class="actions">
                                            <li><i class="table-edit"></i></li>
                                            <li><i class="table-settings"></i></li>
                                            <li class="last"><i class="table-delete"></i></li>
                                        </ul>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="pagination">
                      <ul>
                        <li><a href="#">&#8249;</a></li>
                        <li><a class="active" href="#">1</a></li>
                        <li><a href="#">2</a></li>
                        <li><a href="#">3</a></li>
                        <li><a href="#">4</a></li>
                        <li><a href="#">&#8250;</a></li>
                      </ul>
                    </div>
                    <div>More Templates <a href="http://www.mycodes.net/" target="_blank">源码之家</a> - Collect from <a href="http://www.mycodes.net/" title="网页模板" target="_blank">网页模板</a></div>
                </div>
                <!-- end table sample -->
            </div>
        </div>

</body>
</html>