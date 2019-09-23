@component('mail::message')

    {{-- Header --}}
    @slot('header')
        @component('mail::header', ['url' => config('app.url')])
            Header Title
        @endcomponent
    @endslot

# Hello {{ $data['name'] }},

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
