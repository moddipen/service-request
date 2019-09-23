<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Contracts\Queue\ShouldQueue;

class Subscriptions extends Mailable
{
    use Queueable, SerializesModels;

    protected $data = [], $type;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct($data, $type)
    {
        $this->data = $data;
        $this->type = $type;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        if ($this->type == 'general') {
            return $this->markdown('emails.subscriptions')->subject($this->data['subject'])->with('data',$this->data);
        } else {
            return $this->markdown('emails.assign')->subject($this->data['subject'])->with('data',$this->data);
        }
    }
}
