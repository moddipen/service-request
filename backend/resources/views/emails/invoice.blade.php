<div class="invoice-contents"
     style="background-color:#ffffff; height:1200px; max-width:830px; font-family: Helvetica,Arial,sans-serif !important; position: relative;">
    <table bgcolor="#ffffff" border="0" cellpadding="0" cellspacing="0"
           style="width:100%; background-color:#ffffff;border-collapse:separate !important; border-spacing:0;color:#242128; margin:0;padding:30px; padding-top: 20px;"
           heigth="auto">
        <tbody>
        <tr>
            <td align="left" valign="center"
                style="padding-bottom:35px; padding-top:15px; border-top:0;width:100% !important;">
                <img src="https://coloredstrategies.com/mailing/piaf.png"/>
            </td>
            <td align="right" valign="center" style="padding-bottom:20px;border-top:0;width:100% !important;">
                <p style="color: #8f8f8f; font-weight: normal; line-height: 1.2; font-size: 12px; white-space: nowrap; ">
                    ColoredStrategies Inc<br> 35 Little Russell St. Bloomsburg London,UK<br>784 451 12 47
                </p>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="padding-top:30px; border-top:1px solid #f1f0f0">
                <table style="width: 100%;">
                    <tbody>
                    <tr>
                        <td style="vertical-align:middle; border-radius: 3px; padding:30px; background-color: #f9f9f9; border-right: 5px solid white;">
                            <p style="color:#303030; font-size: 14px;  line-height: 1.6; margin:0; padding:0;">
                                {{ $order->location->email }}<br>{{ $order->location->street }}
                                , {{ $order->location->city }}, {{ $order->location->postal_code }}
                            </p>
                        </td>
                        <td style="text-align: right; padding-top:0px; padding-bottom:0; vertical-align:middle; padding:30px; background-color: #f9f9f9; border-radius: 3px; border-left: 5px solid white;">
                            <p style="color:#8f8f8f; font-size: 14px; padding: 0; line-height: 1.6; margin:0; ">
                                Invoice #: {{ $order->service_request_id }}<br>
                                {{ $order->created_at }}
                            </p>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <table style="width: 100%; margin-top:40px;">
                    <thead>
                    <tr>
                        <th style="text-align:left; font-size: 10px; color:#8f8f8f; padding-bottom: 15px; padding-top:10px; padding-bottom:10px;">
                            TITLE
                        </th>
                        <th style="text-align:right; font-size: 10px; color:#8f8f8f; padding-bottom: 15px; padding-top:10px; padding-bottom:10px;">
                            DESCRIPTIONS
                        </th>
                        <th style="text-align:left; font-size: 10px; color:#8f8f8f; padding-bottom: 15px; padding-top:10px; padding-bottom:10px;">
                            CATEGORY
                        </th>
                        <th style="text-align:right; font-size: 10px; color:#8f8f8f; padding-bottom: 15px; padding-top:10px; padding-bottom:10px;">
                            PRIORITY
                        </th>
                    </tr>
                    </thead>
                    <tbody>
                    @foreach($order->tasks as $task)
                        <tr>
                            <td style="padding-top:0px; padding-bottom:5px; padding-top:10px; padding-bottom:10px;">
                                <p style="font-size: 13px; line-height: 1; margin-bottom:0; color:#303030; font-weight:500; margin-top: 10px;">
                                    {{ $task->title }}</p>
                            </td>
                            <td style="padding-top:0px; padding-bottom:5px; padding-top:10px; padding-bottom:10px;">
                                <p style="font-size: 13px; line-height: 1; margin-bottom:0; color:#303030; font-weight:500; margin-top: 10px;">
                                    {{ $task->descriptions }}</p>
                            </td>
                            <td style="padding-top:10px; padding-bottom:10px;">
                                <p href="#"
                                   style="font-size: 13px; text-decoration: none; line-height: 1; color:#909090; margin-top:0px; margin-bottom:0;">
                                    {{ $task->category->name }}
                                </p>
                            </td>
                            <td style="padding-top:0px; padding-bottom:0; text-align: right; padding-top:10px; padding-bottom:10px;">
                                <p style="font-size: 13px; line-height: 1; color:#303030; margin-bottom:0; margin-top:0; vertical-align:top; white-space:nowrap;">
                                    {{ $task->priority->name }}
                                </p>
                            </td>
                        </tr>
                    @endforeach
                    </tbody>
                </table>
            </td>
        </tr>
        </tbody>
    </table>
    <table bgcolor="#ffffff" border="0" cellpadding="0" cellspacing="0"
           style="position:absolute; bottom:0; width:100%; background-color:#ffffff;border-collapse:separate !important; border-spacing:0;color:#242128; margin:0;padding:30px; padding-top: 20px;"
           heigth="auto">
        <tr>
            <td colspan="3" style="border-top:1px solid #f1f0f0">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="2" style="width: 100%;padding-top:10px; padding-bottom:10px;">
                <p href="#"
                   style="font-size: 13px; text-decoration: none; line-height: 1.6; color:#909090; margin-top:0px; margin-bottom:0; text-align: right;">
                    Subtotal :
                </p>
            </td>
            <td style="padding-top:0px; text-align: right;padding-top:10px; padding-bottom:10px;">
                <p style="font-size: 13px; line-height: 1.6; color:#303030; margin-bottom:0; margin-top:0; vertical-align:top; white-space:nowrap; margin-left:15px">
                    $
                    61.82
                </p>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="width: 100%;padding-top:10px; padding-bottom:10px;">
                <p href="#"
                   style="font-size: 13px; text-decoration: none; line-height: 1.6; color:#909090; margin-top:0px; margin-bottom:0; text-align: right;">
                    Tax :
                </p>
            </td>
            <td style="padding-top:0px; text-align: right;padding-top:10px; padding-bottom:10px;">
                <p style="font-size: 13px; line-height: 1.6; color:#303030; margin-bottom:0; margin-top:0; vertical-align:top; white-space:nowrap; margin-left:15px">
                    $
                    2.18
                </p>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="width: 100%;padding-top:10px; padding-bottom:10px;">
                <p href="#"
                   style="font-size: 13px; text-decoration: none; line-height: 1.6; color:#909090; margin-top:0px; margin-bottom:0; text-align: right;">
                    Shipping :
                </p>
            </td>
            <td style="padding-top:0px; text-align: right;padding-top:10px; padding-bottom:10px;">
                <p style="font-size: 13px; line-height: 1.6; color:#303030; margin-bottom:0; margin-top:0; vertical-align:top; white-space:nowrap; margin-left:15px">
                    $
                    3.21
                </p>
            </td>
        </tr>
        <tr>
            <td colspan="2" style=" width: 100%; padding-bottom:15px; padding-top:10px;">
                <p href="#"
                   style="font-size: 13px; text-decoration: none; line-height: 1.6; color:#909090; margin-top:0px; margin-bottom:0; text-align: right;">
                    <strong>Total : </strong>
                </p>
            </td>
            <td style="padding-top:0px; text-align: right; padding-bottom:15px; padding-top:10px;">
                <p style="font-size: 13px; line-height: 1.6; color:#303030; margin-bottom:0; margin-top:0; vertical-align:top; white-space:nowrap; margin-left:15px">
                    <strong>$
                        68.14</strong>
                </p>
            </td>
        </tr>
        <tr>
            <td colspan="3" style="border-top:1px solid #f1f0f0">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="3">
                @if($order->company_notes)
                    <p style="color: #909090; font-size:11px; text-align:center;">
                        <b>Company notes: </b> {{ $order->company_notes }}
                    </p>
                @endif
                @if($order->contractor_notes)
                    <p style="color: #909090; font-size:11px; text-align:center;">
                        <b>Contractor notes: </b> {{ $order->contractor_notes }}
                    </p>
                @endif
            </td>
        </tr>
    </table>
</div>