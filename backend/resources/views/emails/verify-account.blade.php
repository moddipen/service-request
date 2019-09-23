@component('mail::message')

    {{-- Header --}}
    @slot('header')
        @component('mail::header', ['url' => config('app.url')])
            Header Title
        @endcomponent
    @endslot



<p> Hello,Please Click On the Verify Button To Verify your account </p>

@component('mail::button', ['url' => $url,'color' => 'primary' ])
    Verify Account
@endcomponent

Thanks, <br>

    {{-- Footer --}}
    @slot('footer')
        @component('mail::footer')
            © {{ date('Y') }} {{ config('app.name') }}. Super FOOTER!
        @endcomponent
    @endslot

    {{ config('app.name') }}
@endcomponent
