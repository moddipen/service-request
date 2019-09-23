@component('mail::message')

    {{-- Header --}}
    @slot('header')
        @component('mail::header', ['url' => config('app.url')])
            Header Title
        @endcomponent
    @endslot

<p>{{ $data['message'] }}</p>
<p>{{ $data['name'] }}, Email: {{ $data['email'] }}</p>
<br>

<p> Please click this button to setup your account. </p>

@component('mail::button', ['url' => $data['url'],'color' => 'primary' ])
    Setup your account
@endcomponent

Thanks, <br>

    {{-- Footer --}}
    @slot('footer')
        @component('mail::footer')
            © {{ date('Y') }} {{ config('app.name') }}. Super FOOTER!
        @endcomponent
    @endslot

@endcomponent
