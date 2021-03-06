class AlertsViewHandler < BaseService
  def initialize(operation)
    @operation = operation
  end

  def call
    setup_alerts!
    setup_status!
  end

  private

  attr_reader :operation

  def setup_alerts!
    operation['alerts'] = { message_type => message }.with_indifferent_access
  end

  def setup_status!
    operation['status'] = operation_errors.blank? ? 200 : 422
  end

  def operation_errors
    @errors ||= contract_errors_message || operation['error_message']
  end

  def contract_errors_message
    operation['contract.default'] &&
      operation['contract.default'].errors.full_messages
  end

  def message
    operation_errors.blank? ? operation['success_message'] : operation_errors
  end

  def message_type
    operation_errors.blank? ? 'notice' : 'alert'
  end
end
