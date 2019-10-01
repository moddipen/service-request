@component('mail::message')

    {{-- Header --}}
    @slot('header')
        @component('mail::header', ['url' => config('app.url')])
            Header Title
        @endcomponent
    @endslot

# Hello {{ $data['name'] }},
<br>
<style>
.table td, .table th {
  margin-left:10px;
  padding: 8px;
}

.table tr:nth-child(even){background-color: #f2f2f2;}

.table tr:hover {background-color: #ddd;}

.table th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
    color: white;
}</style>

<div style="width:100% !important;">
<table class="table" width="100%">
<tbody>
<tr>
    <td><b>Title</b></td>
    <td>{{ $data['workOrder']->title }}</td>
</tr>
<tr>
    <td><b>Description</b></td>
    <td>{{ $data['workOrder']->description }}</td>
</tr>
<tr>
    <td><b>Service Req ID</b></td>
    <td>{{ $data['workOrder']->service_request_id }}</td>
</tr>
@if($data['workOrder']->purchase_order_number !== '')
<tr>
    <td><b>Purchase Order No.</b></td>
    <td>{{ $data['workOrder']->purchase_order_number }}</td>
</tr>
@endif
<tr>
    <td><b>Location</b></td>
    <td>{{ $data['workOrder']->location->street }}, {{ $data['workOrder']->location->city }}, {{ $data['workOrder']->location->postal_code }}</td>
</tr>
<tr>
    <td><b>Status</b></td>
    <td>
        @if( $data['workOrder']->status === 0 || $data['workOrder']->status === '0' )
        @php $status = 'Processing'; @endphp
        @elseif($data['workOrder']->status === 1 || $data['workOrder']->status === '1')
        @php $status = 'Closed'; @endphp
        @else
        @php $status = 'Completed'; @endphp
        @endif
        {{ $status}}
    </td>
</tr>

<tr>
    <td><b>Contractor Quotation</b></td>
    <td>{{ $data['workOrder']->contractor_cost }}</td>
</tr>
<tr>
    <td><b>Company Quotation</b></td>
    <td>{{ $data['workOrder']->company_cost }}</td>
</tr>
<tr>
    <td><b>Created On</b></td>
    <td>{{ date('d F, Y', strtotime( $data['workOrder']->created_at)) }} </td>
</tr>
</tbody>
</table>
</div>
<br>

<div style="width:100% !important;">
@if($data['workOrder']->tasks)
    <p><b>Tasks Details:</b></p>
    <table class="table" width="100%">
        <thead>
            <th>
                <tr>
                    <td>Title</td>
                    <td>Desc</td>
                    <td>Category</td>
                    <td>Priority</td>
                    <td>Added On</td>
                </tr>
            </th>
        </thead>

        <tbody>
            @foreach($data['workOrder']->tasks as $key => $value)
            <tr>
                <td>{{$value->title}}</td>
                <td>{{$value->description}}</td>
                <td>{{$value->category->name}}</td>
                <td>{{$value->priority->name}}</td>
                <td>{{ date('d F, Y', strtotime( $value->created_at)) }}</td>
            </tr>  

            @endforeach
        </tbody>
    </table>
@else
    <h3>No tasks created.</h3>
@endif
</div>
<br>



<p> {{ $data['message'] }} </p>

@component('mail::button', ['url' => $data['url'],'color' => 'primary' ])
    Service request
@endcomponent

Thanks <br>

    {{-- Footer --}}
    @slot('footer')
        @component('mail::footer')
            © {{ date('Y') }} {{ config('app.name') }}. Super FOOTER!
        @endcomponent
    @endslot
@endcomponent
