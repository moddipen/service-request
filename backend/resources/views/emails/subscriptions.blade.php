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

Thanks <br>

    {{-- Footer --}}
    @slot('footer')
        @component('mail::footer')
            © {{ date('Y') }} {{ config('app.name') }}. Super FOOTER!
        @endcomponent
    @endslot
@endcomponent
