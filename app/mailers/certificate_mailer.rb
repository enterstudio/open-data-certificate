class CertificateMailer < ActionMailer::Base

  default from: Devise.mailer_sender

  def report(certificate, reason, reporter)
    @certificate = certificate
    @reason = reason
    @reporter = reporter
    from = @reporter[:email].presence || Devise.mailer_sender

    mail(subject: "Reported certificate: #{certificate.name}", to: Devise.mailer_sender, from: from)
  end
  
end
